#!/usr/bin/env python3
import re
import util
import constants as const
from program import OpcodeGenerator


class Assembler:
    # Ex, matches [r13+1234]
    INDEXERAD_ARGUMENT_PATTERN = re.compile(r"\[r([0-9]|1[0-5])[+-]\d+\]")
    # Ex, matches [1234], [500]
    DIREKT_ARGUMENT_PATTERN = re.compile(r"\[\d+\]")
    # Ex, matches [r0], [r15]
    INDIREKT_ARGUMENT_PATTERN = re.compile(r"\[r(1[0-5]|[0-9])\]")

    REGISTER_PATTERN = re.compile(r"r(1[0-5]|[0-9])")

    CONSTANT_PATTERN = re.compile(r"-?\d+")

    OFFSET_PATTERN = re.compile(r"[+-]\d+")

    def __init__(self, instructions_table, mod_codes):
        op_codes = {operation: config[const.OP_CODES_KEY] for operation, config in instructions_table.items()}
        self.instructions_table = instructions_table
        self.opcode_generator = OpcodeGenerator(op_codes, mod_codes)
        self.error_trace_msg = "file: ???, line: ???"

    def assemble(self, source_code):
        return self._assemble_instructions(source_code)

    def _assemble_instructions(self, source_code):
        parse_error = False

        source_code = source_code.replace("'", "").replace(" ", "").splitlines()
        source_file_name = source_code[0]

        i = 0
        for line in source_code[1:]:
            tokens = line[1:-1].split(',')
            line_num = tokens[0]
            instruction = tokens[1:]
            self.error_trace_msg = f"file: {source_file_name}, line: {line_num}"

            opcode = self._create_opcode(instruction)
            print(f"{i}: ", end="")
            i += 1
            self.opcode_generator.print_opcode(opcode)
            yield opcode

        util.exit_if(parse_error)

    def _create_opcode(self, instruction):
        operation = instruction[0]
        arguments = instruction[1:]

        create_instruction_callback = {
            const.OMEDELBAR_MOD_KEY: self._create_omedelbar_mod_instruction,
            const.DIREKT_REGISTER_MOD_KEY: self._create_direkt_register_mod_instruction,
            const.DIREKT_FRÅN_MOD_KEY: self._create_direkt_från_mod_instruction,
            const.INDIREKT_FRÅN_MOD_KEY: self._create_indirekt_från_mod_instruction,
            const.INDEXERAD_FRÅN_MOD_KEY: self._create_indexerad_från_mod_instruction,
            const.DIREKT_TILL_MOD_KEY: self._create_direkt_till_mod_instruction,
            const.INDIREKT_TILL_MOD_KEY: self._create_indirekt_till_mod_instruction,
            const.INDEXERAD_TILL_MOD_KEY: self._create_indexerad_till_mod_instruction,
        }

        operation_config = self.instructions_table[operation]
        required_arguments = operation_config[const.ARGUMENTS_KEY]
        argument_count = len(arguments)
        instruction_fields = {}
        supported_modes = operation_config[const.MOD_SUPPORT_KEY]
        instruction_mod = None

        def unsupported_mod():
            if instruction_mod is None and len(supported_modes) != 0:
                util.print_error(f"Unsupported instruction mod for operation {operation}: {self.error_trace_msg}")
                return True

            return False

        def incorrect_argument_count():
            if argument_count != required_arguments:
                util.print_error(
                    f"Operation {operation} requires {required_arguments} arguments, but {argument_count} was provided")
                return True

            return False

        util.exit_if(incorrect_argument_count())

        for mod in supported_modes:
            instruction_fields = create_instruction_callback[mod](arguments, argument_count)

            if not instruction_fields is None:
                instruction_mod = mod
                break

        util.exit_if(unsupported_mod())
        instruction_mod = const.OMEDELBAR_MOD_KEY if instruction_mod is None else instruction_mod

        # fields = {"Rd": 0, "Ra": 0, "address": 0}
        return self.opcode_generator.create(op=operation, mod=instruction_mod, **instruction_fields)

    def _create_omedelbar_mod_instruction(self, arguments, argument_count):
        match argument_count:
            case 1:
                arg0 = arguments[0]
                if Assembler._is_constant_argument(arg0):
                    return {"constant": int(arg0)}
            case 2:
                arg0, arg1 = arguments[0:2]
                if Assembler._is_register_argument(arg0) and Assembler._is_constant_argument(arg1):
                    return {"Rd": arg0, "constant": int(arg1)}

        return None

    def _create_direkt_register_mod_instruction(self, arguments, argument_count):
        match argument_count:
            case 1:
                arg0 = arguments[0]
                if Assembler._is_register_argument(arg0):
                    return {"Rd": arg0, "Ra": arg0}
            case 2:
                arg0, arg1 = arguments[0:2]
                if Assembler._is_register_argument(arg0) and Assembler._is_register_argument(arg1):
                    return {"Rd": arg0, "Ra": arg1}

        return None

    def _create_direkt_från_mod_instruction(self, arguments, argument_count):
        match argument_count:
            case 1:
                arg0 = arguments[0]
                if Assembler._is_direkt_argument(arg0):
                    return {"address": int(arg0.strip("]["))}
            case 2:
                arg0, arg1 = arguments[0:2]
                if Assembler._is_register_argument(arg0) and Assembler._is_direkt_argument(arg1):
                    return {"Rd": arg0, "address": int(arg1.strip("]["))}

        return None

    def _create_indirekt_från_mod_instruction(self, arguments, argument_count):
        match argument_count:
            case 1:
                arg0 = arguments[0]
                if Assembler._is_indirekt_argument(arg0):
                    return {"Ra": arg0.strip("][")}
            case 2:
                arg0, arg1 = arguments[0:2]
                if Assembler._is_register_argument(arg0) and Assembler._is_indirekt_argument(arg1):
                    return {"Rd": arg0, "Ra": arg1.strip("][")}

        return None

    def _create_indexerad_från_mod_instruction(self, arguments, argument_count):
        match argument_count:
            case 1:
                arg0 = arguments[0]
                if Assembler._is_indexerad_argument(arg0):
                    Ra_span = Assembler.REGISTER_PATTERN.search(arg0).span()
                    address_span = Assembler.OFFSET_PATTERN.search(arg0).span()
                    return {"Ra": arg0[Ra_span[0]:Ra_span[1]], "address": int(arg0[address_span[0]:address_span[1]])}
            case 2:
                arg0, arg1 = arguments[0:2]
                if Assembler._is_register_argument(arg0) and Assembler._is_indexerad_argument(arg1):
                    Ra_span = Assembler.REGISTER_PATTERN.search(arg1).span()
                    address_span = Assembler.OFFSET_PATTERN.search(arg1).span()
                    return {"Rd": arg0, "Ra": arg1[Ra_span[0]:Ra_span[1]],
                            "address": int(arg1[address_span[0]:address_span[1]])}

        return None

    def _create_direkt_till_mod_instruction(self, arguments, argument_count):
        match argument_count:
            case 1:
                arg0 = arguments[0]
                if Assembler._is_direkt_argument(arg0):
                    return {"address": int(arg0.strip("]["))}
            case 2:
                arg0, arg1 = arguments[0:2]
                if Assembler._is_direkt_argument(arg0) and Assembler._is_register_argument(arg1):
                    return {"Ra": arg1, "address": int(arg0.strip("]["))}

        return None

    def _create_indirekt_till_mod_instruction(self, arguments, argument_count):
        match argument_count:
            case 1:
                arg0 = arguments[0]
                if Assembler._is_indirekt_argument(arg0):
                    return {"Rd": arg0.strip("][")}
            case 2:
                arg0, arg1 = arguments[0:2]
                if Assembler._is_indirekt_argument(arg0) and Assembler._is_register_argument(arg1):
                    return {"Rd": arg0.strip("]["), "Ra": arg1}

        return None

    def _create_indexerad_till_mod_instruction(self, arguments, argument_count):
        match argument_count:
            case 1:
                arg0 = arguments[0]
                if Assembler._is_indexerad_argument(arg0):
                    Rd_span = Assembler.REGISTER_PATTERN.search(arg0).span()
                    address_span = Assembler.OFFSET_PATTERN.search(arg0).span()
                    return {"Rd": arg0[Rd_span[0]:Rd_span[1]], "address": int(arg0[address_span[0]:address_span[1]])}

            case 2:
                arg0, arg1 = arguments[0:2]
                if Assembler._is_indexerad_argument(arg0) and Assembler._is_register_argument(arg1):
                    Rd_span = Assembler.REGISTER_PATTERN.search(arg0).span()
                    address_span = Assembler.OFFSET_PATTERN.search(arg0).span()
                    return {"Rd": arg0[Rd_span[0]:Rd_span[1]], "Ra": arg1,
                            "address": int(arg0[address_span[0]:address_span[1]])}

        return None

    @staticmethod
    def _is_constant_argument(argument):
        return Assembler.CONSTANT_PATTERN.match(argument) is not None

    @staticmethod
    def _is_register_argument(argument):
        return Assembler.REGISTER_PATTERN.match(argument) is not None

    @staticmethod
    def _is_direkt_argument(argument):
        return Assembler.DIREKT_ARGUMENT_PATTERN.match(argument) is not None

    @staticmethod
    def _is_indirekt_argument(argument):
        return Assembler.INDIREKT_ARGUMENT_PATTERN.match(argument) is not None

    @staticmethod
    def _is_indexerad_argument(argument):
        return Assembler.INDEXERAD_ARGUMENT_PATTERN.match(argument) is not None
