import os
import util
import constants as const


def check_binary_file(binary_file):
    file_error = False

    if not binary_file.endswith(".bin"):
        util.print_error(
            f"Binary file {binary_file} does not have a .bin file ending, invalid bin file.")
        file_error = True

    return file_error


def check_datamem_data(datamem, memory_address_data):
    data_error = False

    if not isinstance(datamem, dict):
        util.print_error(
            f"{const.DATA_MEMORY_KEY} in {const.MEMORY_DATA_FILE} should be a dictionary.")
        return True

    datamem_len = 1 + util.to_decimal(memory_address_data[const.DM_END_KEY]) - util.to_decimal(
        memory_address_data[const.DM_START_KEY])

    actual_len = sum(len(data) for data in datamem.values())

    if actual_len > datamem_len:
        util.print_error(
            f"{const.DATA_MEMORY_KEY} in {const.MEMORY_DATA_FILE} should have max {datamem_len} entires, has {actual_len} instead.")
        data_error = True

    return data_error


def check_vram_data(vram_data, memory_address_data):
    data_error = False

    if not isinstance(vram_data, list):
        util.print_error(
            f"{const.VRAM_KEY} in {const.MEMORY_DATA_FILE} should be a list.")
        return True

    vram_len = 1 + util.to_decimal(memory_address_data[const.VRAM_END_KEY]) - util.to_decimal(
        memory_address_data[const.VRAM_START_KEY])

    assert vram_len == (const.VRAM_COLUMNS *
                        const.VRAM_ROWS), "Video memory columns and rows count does not match vram address range."

    final_row_num = 0
    for row_num, data_row in enumerate(vram_data):
        final_row_num = row_num
        columns = len(data_row)

        if columns != const.VRAM_COLUMNS:
            util.print_error(
                f"Row {row_num} in {const.VRAM_KEY} in {const.MEMORY_DATA_FILE} should have {const.VRAM_COLUMNS} entires, has {columns} instead.")
            data_error = True

    final_row_num += 1

    if final_row_num != const.VRAM_ROWS:
        util.print_error(f"{const.VRAM_KEY} in {const.MEMORY_DATA_FILE} does not have {const.VRAM_ROWS} rows.")
        data_error = True

    return data_error


def check_sprite_table(sprite_table, memory_address_data):
    data_error = False

    if not isinstance(sprite_table, dict):
        util.print_error(
            f"{const.SPRITES_KEY} in {const.MEMORY_DATA_FILE} should be a dict.")
        return True

    sprite_data_len = 1 + util.to_decimal(
        memory_address_data[const.SPRITE_END_KEY]) - util.to_decimal(
        memory_address_data[const.SPRITE_START_KEY])

    if len(sprite_table) != sprite_data_len:
        util.print_error(
            f"{const.SPRITES_KEY} in {const.MEMORY_ADDRESS_FILE} should contain exactly 8 entires.")
        data_error = True

    return data_error


def check_source_files(source_files):
    file_error = False

    if len(source_files) == 0:
        util.print_error("No source files given.")
        file_error = True

    # Check if all files exist.

    for src in source_files:
        if not os.path.isfile(src):
            util.print_error(f"File {src} is not a valid source file.")
            file_error = True
        elif not src.endswith(".asm"):
            util.print_error(
                f"File {src} does not have .asm file ending, not valid source file.")
            file_error = True

    return file_error
