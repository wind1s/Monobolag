import re
import sympy
import util
import constants as const


class PreProcessor:
    HEX_PATTERN = re.compile(r"0[xX][0-9a-fA-F]+")
    BINARY_PATTERN = re.compile(r"0[bB][0-1]+")

    def __init__(self, symbols: dict, memory_address_data: dict):
        self.symbols: dict = symbols
        self.progmem_start_address: int = util.to_decimal(memory_address_data[const.PM_START_KEY])
        self.progmem_size: int = 1 + util.to_decimal(
            memory_address_data[const.PM_END_KEY]) - self.progmem_start_address
        self.address_offset = 0

    def preprocess(self, source_file_name):
        def too_large_program():
            if self.address_offset >= self.progmem_size:
                util.print_error(
                    f"Program uses {self.address_offset} rows of program memory, max is {self.progmem_size}")
                return True

            return False

        source_data = ""
        with open(source_file_name, "r", encoding="utf-8") as source_file:
            source_data = source_file.read()

        source_data = f"jmp start\n{source_data}"

        util.print_info(f"Preprocessing source file {source_file_name}")

        processed_source = self._process_labels_and_tokenize_instructions(source_data)
        util.exit_if(too_large_program())

        processed_source = self._process_evaluate_expressions(processed_source)
        processed_source = processed_source.lower()
        processed_source_with_file_name = f"{source_file_name}\n{processed_source}"

        return processed_source_with_file_name

    def _process_labels_and_tokenize_instructions(self, source_data: str):
        processed_source = ""

        for line_num, line in enumerate(source_data.splitlines()):
            line: str = line.strip()

            if line.startswith(";") or len(line) == 0:
                continue

            if line.endswith(":"):
                label = line[:-1]

                if label in self.symbols:
                    util.print_error(f"Symbol {label} at line {line_num} is already defined outside of source code.")
                    exit(-1)

                self.symbols[label] = self.progmem_start_address + self.address_offset
                continue

            split_index = line.find(" ")
            processed_line = ""

            if split_index != -1:
                operation = line[:split_index]
                arguments = line[split_index + 1:]
                processed_line = f"[{line_num},{operation},{arguments}]\n"
            else:
                operation = line
                processed_line = f"[{line_num},{operation}]\n"

            processed_source += processed_line.replace(" ", "")
            self.address_offset += 1

        return processed_source

    def _eval_const_expression(self, expression):
        start_bracket_pos = expression.find("[")
        end_bracket_pos = expression.find("]")
        address_mod = start_bracket_pos != -1 and end_bracket_pos != -1

        evaluation = str(sympy.simplify(sympy.sympify(expression.strip("[]"))))

        if address_mod:
            evaluation = f"[{evaluation}]"

        return evaluation.replace(" ", "")

    def _process_evaluate_expressions(self, source_data):
        processed_source = ""

        hex_numbers = self.HEX_PATTERN.findall(source_data)
        binary_numbers = self.BINARY_PATTERN.findall(source_data)

        numbers = set(hex_numbers + binary_numbers)

        for num in numbers:
            source_data = source_data.replace(num, str(util.to_decimal(num)))

        # Sorting hinders symbols which are substrings of others symbols from
        # incorrectly replacing them.
        sorted_keys = sorted(list(self.symbols.items()), key=lambda x: len(x[0]))
        sorted_keys.reverse()
        sorted_keys = dict(sorted_keys)

        for symbol, value in sorted_keys.items():
            source_data = source_data.replace(symbol, str(value))

        for line in source_data.splitlines():
            tokens = line[1:-1].split(',')

            for i in range(2, len(tokens)):
                token = tokens[i]
                if token != "":
                    tokens[i] = self._eval_const_expression(token)

            processed_source += str(tokens) + "\n"

        return processed_source
