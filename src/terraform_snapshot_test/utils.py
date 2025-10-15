import json
import os
import subprocess
from operator import itemgetter
from typing import Any, Dict, List

from yaml import safe_load


# Takes care of the path
def sanitise_file_path(file_path: str, working_directory: str = ".") -> str:
    if working_directory == ".":
        return file_path
    elif working_directory.endswith("/"):
        return f"{working_directory}{file_path}"
    else:
        return f"{working_directory}/{file_path}"


# Runs tflocal and return the json manifest
def synthetise_terraform_json(file_path: str, working_directory: str = ".") -> Any:
    os.makedirs("tests/__snapshots__", exist_ok=True)

    # Run tflocal script
    subprocess.run(
        f"{os.environ["TF_TEST_CMD"]} init", shell=True, check=True, cwd=working_directory, env=os.environ.copy()
    )
    subprocess.run(
        f"{os.environ["TF_TEST_CMD"]} validate", shell=True, check=True, cwd=working_directory, env=os.environ.copy()
    )
    subprocess.run(
        f"{os.environ["TF_TEST_CMD"]} plan -out={file_path}.plan",
        shell=True,
        check=True,
        cwd=working_directory,
        env=os.environ.copy(),
    )
    subprocess.run(
        f"{os.environ["TF_TEST_CMD"]} show -json {file_path}.plan > {file_path}.json",
        shell=True,
        check=True,
        cwd=working_directory,
        env=os.environ.copy(),
    )

    # Load the generated json and return
    with open(f"{sanitise_file_path(file_path, working_directory)}.json") as f:
        return json.load(f)


# Sort the lists within the dictionary and sub-dictionaries
def sort_lists_in_dictionary(
    dictionary: Dict[str, Any], sort_key: str = "address", sort_attributes: List[str] = ["modules", "child_modules"]
) -> Dict[str, Any]:
    for k in dictionary.keys():

        # If list, sort and call resursively for each element
        if isinstance(dictionary[k], list) and k in sort_attributes:
            sorted_list = sorted(dictionary[k], key=itemgetter(sort_key))
            dictionary[k] = []
            for element in sorted_list:
                if isinstance(element, dict):
                    element = sort_lists_in_dictionary(
                        dictionary=element, sort_key=sort_key, sort_attributes=sort_attributes
                    )
                dictionary[k].append(element)

        # If dictionary, call recursively
        if isinstance(dictionary[k], dict):
            dictionary[k] = dict(
                sort_lists_in_dictionary(dictionary=dictionary[k], sort_key=sort_key, sort_attributes=sort_attributes)
            )

    return dictionary


# DRY to load json from file
def get_json_from_file(file_path: str, working_directory: str = ".") -> Any:
    payload = {}
    with open(sanitise_file_path(file_path, working_directory)) as f:
        payload = json.load(f)
    return payload


# Verify if the expectaiton contains the right format
def verify_expectation_schema(expectation: Dict[str, Any], file_path: str) -> None:

    # Mandatory fields
    mandatory_fields = {"description", "module", "synthesis", "planned_values"}
    if not mandatory_fields.issubset(expectation.keys()):
        raise ValueError(
            f"Expectation '{file_path}' is missing one or more of the mandatory attributes {mandatory_fields}"
        )

    # Check assertions attribute presence
    for attribute in ["synthesis", "planned_values"]:
        if not {"assertions"}.issubset(expectation[attribute].keys()):
            raise ValueError(f"Expectation '{file_path}' '{attribute}' attribute is missing an 'assertions' attribute")

    return


# Load the expectations into dictionary
def load_expectations(folder_path: str) -> List[Any]:
    module_expectations: List[Any] = []

    # If folder doesn't exist, return
    if not os.path.isdir(folder_path):
        return module_expectations

    # Iterate all files in the folder
    for root, _, files in os.walk(folder_path):
        path = root.split(os.sep)
        for file_name in files:
            # Only process yaml files
            if file_name.split(".")[-1] not in ["yml", "yaml"]:
                continue

            # Safe-load the yaml
            file_path = "/".join(path + [file_name])
            with open(file_path, "r", encoding="utf-8") as f:
                expectations = safe_load(f)

                # Verify if the expecations are correct
                verify_expectation_schema(expectation=expectations, file_path=file_path)
                module_expectations.append(expectations)

    return module_expectations


# Run the assertions
def run_assertions(snapshot: Any, expectations: List[Any], snapshot_type: str) -> None:

    return


# User method
def assert_expectations(
    snapshot: Any, snapshot_type: str, folder_path: str = "expectations", working_directory: str = "."
) -> None:

    # Verify input
    valid_snapshot_types = ["synthesis", "planned_values"]
    if snapshot_type not in valid_snapshot_types:
        raise ValueError(f"Argument 'snapshot_type' must be one of '{json.dumps(valid_snapshot_types)}'")

    # Load expectations
    expectations = load_expectations(folder_path=f"{working_directory}/{folder_path}")

    # If no expectations found, return
    if not expectations:
        return

    # Test expectations
    run_assertions(snapshot=snapshot, expectations=expectations, snapshot_type=snapshot_type)

    return


if __name__ == "__main__":
    expectations = load_expectations(folder_path="../../tests/aws-s3-bucket/tests/expectations/")
    # print(json.dumps(expectations, indent=2))
