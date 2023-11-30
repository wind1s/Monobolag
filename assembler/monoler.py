#!/usr/bin/env python3
import struct
import json
import sys
import util
import checks
from assembler import Assembler
from preprocessor import PreProcessor
import constants as const


def write_data_with_address(file, data, address):
    assert file.writable, "file has to be writable"
    assert data.bit_length() <= 32, "data argument has to fit in 32 bits"
    assert address.bit_length() <= 16, "address argument has to fit in 16 bits"

    file.write(struct.pack("!IH", data, address))


def write_data_with_base_address(file, data_to_write, base_address):
    for offset, data in enumerate(data_to_write):
        write_data_with_address(file, data, offset + base_address)


def get_instruction_config():
    instructions_table = {}
    mod_codes = {}
    op_field_sizes = {}
    with open(const.INSTRUCTION_CONFIG_FILE, "r", encoding="utf-8") as json_file:
        file_data = json.load(json_file)
        instructions_table = file_data[const.INSTRUCTIONS_TABLE_KEY]
        mod_codes = file_data[const.MOD_CODES_KEY]
        op_field_sizes = file_data[const.OP_FIELD_SIZES]

    return (instructions_table, mod_codes, op_field_sizes)


def get_symbols(memory_data_file_name, memory_address_data):
    datamem_start_address = util.to_decimal(memory_address_data[const.DM_START_KEY])
    sprite_start_address = util.to_decimal(memory_address_data[const.SPRITE_START_KEY])
    constants = {}
    data_memory = {}
    sprite_table = {}

    with open(memory_data_file_name, "r", encoding="utf-8") as json_file:
        file_data = json.load(json_file)
        constants = file_data[const.CONSTANTS_KEY]
        data_memory = file_data[const.DATA_MEMORY_KEY]
        sprite_table = file_data[const.SPRITES_KEY]

    def is_key_collision():
        collisions = list(set(constants.keys()).intersection(
            data_memory.keys()).intersection(sprite_table.keys()))

        if len(collisions) != 0:
            util.print_error(
                f"Duplicate keys found in code constants and data memory: {collisions}")
            return True

        return False

    util.exit_if(is_key_collision())

    symbols = {name: util.to_decimal(value)
               for name, value in constants.items()}

    offset = datamem_start_address
    for label in data_memory.keys():
        symbols[label] = offset
        offset += len(data_memory[label])

    offset = sprite_start_address
    for label in sprite_table.keys():
        symbols[label] = offset
        offset += 1

    return symbols


def prepare_datamem(datamem):
    linear_datamem = []

    for data_row in datamem.values():
        linear_datamem += [util.to_decimal(data) for data in data_row]

    return linear_datamem


def prepare_vram(vram_data):
    linear_vram = []

    for data_row in vram_data:
        linear_vram += [util.to_decimal(data) for data in data_row]

    return linear_vram


def prepare_sprite_table(sprite_table):
    linear_sprite_table = []

    for data in sprite_table.values():
        linear_sprite_table.append(util.to_decimal(data))

    return linear_sprite_table


def get_datamem_vram_sprites(data_file, memory_address_data):
    datamem = []
    vram = []
    sprite_table = []

    with open(data_file, "r", encoding="utf-8") as json_file:
        file_data = json.load(json_file)
        datamem = file_data[const.DATA_MEMORY_KEY]
        vram = file_data[const.VRAM_KEY]
        sprite_table = file_data[const.SPRITES_KEY]

    util.exit_if(checks.check_datamem_data(datamem, memory_address_data))
    util.exit_if(checks.check_vram_data(vram, memory_address_data))
    util.exit_if(checks.check_sprite_table(sprite_table, memory_address_data))

    datamem = prepare_datamem(datamem)
    vram = prepare_vram(vram)
    sprite_table = prepare_sprite_table(sprite_table)

    return (datamem, vram, sprite_table)


def main():
    if len(sys.argv) != 3:
        util.print_error("Requires 2 arguments, .asm source file and .json data file")
        exit(-1)

    source_file = sys.argv[1]
    memory_data_file = sys.argv[2]

    config_file_metadata = (
        {"file": const.INSTRUCTION_CONFIG_FILE,
         "keys": [const.INSTRUCTIONS_TABLE_KEY, const.MOD_CODES_KEY, const.OP_FIELD_SIZES]},
        {"file": const.MEMORY_ADDRESS_FILE,
         "keys": [const.PM_START_KEY, const.PM_END_KEY, const.DM_START_KEY, const.DM_END_KEY]},
        {"file": memory_data_file,
         "keys": [const.CONSTANTS_KEY, const.DATA_MEMORY_KEY, const.VRAM_KEY, const.SPRITES_KEY]}
    )

    util.exit_if(checks.check_source_files([source_file]))
    util.exit_if(util.check_config_files(config_file_metadata))

    memory_address_data = {}
    with open(const.MEMORY_ADDRESS_FILE, "r", encoding="utf-8") as json_file:
        memory_address_data = json.load(json_file)

    symbols = get_symbols(memory_data_file, memory_address_data)
    preprocessor = PreProcessor(symbols, memory_address_data)
    source_code = preprocessor.preprocess(source_file)

    instructions_table, mod_codes, _ = get_instruction_config()

    assembler = Assembler(instructions_table, mod_codes)
    progmem = assembler.assemble(source_code)

    datamem, vram, sprite_table = get_datamem_vram_sprites(memory_data_file, memory_address_data)

    sprite_start_address = util.to_decimal(
        memory_address_data[const.SPRITE_START_KEY])
    vram_start_address = util.to_decimal(
        memory_address_data[const.VRAM_START_KEY])
    progmem_start_address = util.to_decimal(
        memory_address_data[const.PM_START_KEY])
    datamem_start_address = util.to_decimal(
        memory_address_data[const.DM_START_KEY])

    # binary_file_name = source_file.strip('.asm') + ".bin"
    binary_file_name = "output.bin"
    with open(binary_file_name, "wb") as binary_output:
        write_data_with_base_address(binary_output, progmem, progmem_start_address)
        write_data_with_base_address(binary_output, datamem, datamem_start_address)
        write_data_with_base_address(binary_output, vram, vram_start_address)
        write_data_with_base_address(binary_output, sprite_table, sprite_start_address)


if __name__ == "__main__":
    main()
