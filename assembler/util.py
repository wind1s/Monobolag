import json
import os


def to_decimal(number):
    if isinstance(number, int):
        return number

    assert isinstance(number, str), "If number is not an int, it must be string format"

    base = 10
    match number[:2]:
        case "0x":
            base = 16
        case "0b":
            base = 2
        case _:
            assert False, "unsupported base"

    return int(number, base)


def exit_if(should_exit, exit_code=-1):
    if should_exit:
        exit(exit_code)


def print_error(message, *args, **kwargs):
    print("\u001b[31mERROR\u001b[0m: {}".format(message), *args, **kwargs)


def print_warning(message, *args, **kwargs):
    print("\u001b[33mWARNING\u001b[0m: {}".format(message), *args, **kwargs)


def print_info(message, *args, **kwargs):
    print("INFO: {}".format(message), *args, **kwargs)


def check_config_keys(config_file, keys_to_check):
    with open(config_file, "r", encoding="utf-8") as json_file:
        file_data = json.load(json_file)

        def check(key):
            if key not in file_data:
                print_error(
                    f"Field \"{key}\" does not exist in {config_file}")
                return True

            key_data = file_data[key]
            if (isinstance(key_data, dict) or isinstance(key_data, list)) and len(file_data[key]) == 0:
                print_info(
                    f"Field \"{key}\" in {config_file} has 0 elements")

            return False

        return any([check(key) for key in keys_to_check])


def check_config_files(config_file_metadata):
    config_error = False

    for metadata in config_file_metadata:
        config_file = metadata["file"]

        if not os.path.isfile(config_file):
            print_error(
                f"Config file {config_file} is not a valid config file.")
            config_error = True

        elif not config_file.endswith(".json"):
            print_error(
                f"Config file {config_file} does not have a .json file ending, not a valid config file.")
            config_error = True

        elif check_config_keys(config_file, metadata["keys"]):
            config_error = True

    return config_error
