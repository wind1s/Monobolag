#!/usr/bin/env python3
import serial
import struct
import time
import sys
import util
import checks
import constants as const


class OpcodeGenerator():
    def __init__(self, op_codes, mod_codes):
        self.op_codes = op_codes
        self.mod_codes = mod_codes
        self.registers = {f"r{num}": num for num in range(0, 16)}

    def create(self,
               op, mod="omedelbar", Rd="r0", Ra="r0", address=0, constant=None):
        self._check_opcode_fields(op=op, mod=mod, Rd=Rd, Ra=Ra, address=address, constant=constant)

        op = self.op_codes[op]
        mod = self.mod_codes[mod]
        Rd = self.registers[Rd]
        Ra = self.registers[Ra]

        address_size = 16
        constant_size = 20

        def too_big_address_size():
            if address >= (1 << address_size):
                util.print_error(
                    f"address is larger {address_size} bits, currently {address} >= {(1 << address_size)}")
                return True

            return False

        def too_big_constant_size():
            if constant >= (1 << constant_size):
                util.print_error(
                    f"constant is larger than {constant_size} bits, currently {constant} >= {(1 << constant_size)}")
                return True

            return False

        ra_address_or_constant = 0

        if constant is None:
            util.exit_if(too_big_address_size())
            # Add 2**address_size to convert to two's complement.
            address_mask = (1 << address_size) - 1
            address = (address + (1 << address_size))
            ra_address_or_constant = (Ra << address_size) | (address & address_mask)
        else:
            util.exit_if(too_big_constant_size())
            # Add 2**constant to convert to two's complement.
            constant_mask = (1 << constant_size) - 1
            constant = (constant + (1 << constant_size))
            ra_address_or_constant = constant & constant_mask

        # Mask bits to use max size in bits.
        reserve_bits = max(address_size, constant_size)
        opcode = (op << 27) | (mod << 24) | (Rd << reserve_bits) | ra_address_or_constant
        return opcode

    def _check_opcode_fields(self,
                             op, mod, Rd, Ra, address, constant):
        assert isinstance(op, str), "op has to be a string"
        assert isinstance(mod, str), "mod has to be a string"
        assert isinstance(Rd, str), "Rd has to be a string"
        assert isinstance(Ra, str), "Ra has to be a string"
        assert isinstance(address, int), "address has to be a int"
        assert constant is None or isinstance(
            constant, int), "constant has to be none or int"

        assert mod in self.mod_codes, f"{mod} is not a valid instruction mode"
        assert op in self.op_codes, f"{op} is not a valid operation"

        assert Rd in self.registers, f"{Rd} is not a valid register"
        assert Ra in self.registers, f"{Ra} is not a valid register"

    @staticmethod
    def print_opcode(opcode):
        binary = bin(opcode)[2:].zfill(32)
        address = int(f"0b{binary[16:]}", 2)
        print(
            f"Op: {binary[:5]}, Mod: {binary[5:8]}, Rd: {binary[8:12]}, Ra: {binary[12:16]}, Address: {address}")


class UARTInterface():
    def __init__(self, port,
                 baudrate=115200,
                 bytesize=serial.EIGHTBITS,
                 parity=serial.PARITY_NONE,
                 stopbits=serial.STOPBITS_ONE):

        self.interface = serial.Serial(
            port=port,
            baudrate=baudrate,
            bytesize=bytesize,
            parity=parity,
            stopbits=stopbits
        )

    def write_bytes(self, byte_data):
        for byte in byte_data:
            s = struct.pack("!B", byte)
            self.interface.write(s)
            # Do not lower the delay or it will corrupt the memory.
            time.sleep(0.0002)

    def write_to_address(self, data, address):
        bit_count = 8
        mask_bits = int("0b" + ("1" * bit_count), 2)

        bytes_packet = [
            (data & mask_bits),
            (data & (mask_bits << bit_count)) >> bit_count,
            (data & (mask_bits << (2 * bit_count))) >> (2 * bit_count),
            (data & (mask_bits << (3 * bit_count))) >> (3 * bit_count),
            (address & mask_bits),
            (address & (mask_bits << bit_count)) >> bit_count
        ]

        self.write_bytes(bytes_packet)

    def start_chip(self):
        self.write_to_address(0, util.to_decimal("0xFFFF"))

    def program_chip(self, program_data_addresses):
        print("Programming chip...")
        for data, address in program_data_addresses:
            self.write_to_address(data, address)

        print("Starting chip...")
        self.start_chip()
        print("Complete!")


def read_binary_file_data(binary_name):
    if binary_name == "":
        return []

    program_data_address = []

    with open(binary_name, "rb") as binary_file:
        data_address = read_instruction(binary_file)

        while data_address is not None:
            program_data_address.append(data_address)
            data_address = read_instruction(binary_file)

    return program_data_address


def read_instruction(binary_file):
    assert binary_file.readable, "file has to be readable"
    read_size = 6
    buffer = binary_file.read(read_size)

    if len(buffer) < read_size:
        return None

    return struct.unpack("!IH", buffer)


def extract_binary_name_from_cmd(args):
    argv_len = len(args)
    binary_file = ""

    if argv_len > 1:
        binary_file = sys.argv[1]
        util.exit_if(checks.check_binary_file(binary_file))

        if argv_len > 2:
            util.print_warning("Only using the first provided binary file.")
    else:
        util.print_info("Programming with only memory data")

    return binary_file


def main():
    binary_name = extract_binary_name_from_cmd(sys.argv)

    config_files_metadata = [
        {"file": const.MEMORY_ADDRESS_FILE,
         "keys": (const.VRAM_START_KEY, const.VRAM_END_KEY, const.SPRITE_START_KEY, const.SPRITE_END_KEY)}
    ]

    util.exit_if(util.check_config_files(config_files_metadata))

    program_data_address = read_binary_file_data(binary_name)
    """
    for data, address in program_data_address:
        print(f"address: {address}")
        OpcodeGenerator.print_opcode(data)
    """

    interface = UARTInterface(
        port="/dev/ttyUSB0",
        baudrate=115200,
        bytesize=serial.EIGHTBITS,
        parity=serial.PARITY_NONE,
        stopbits=serial.STOPBITS_ONE,
    )

    interface.program_chip(program_data_address)


if __name__ == "__main__":
    main()
