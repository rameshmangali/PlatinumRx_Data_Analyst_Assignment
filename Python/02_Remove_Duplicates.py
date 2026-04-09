def remove_duplicates(input_string):
    """
    You are given a string, remove all the duplicates and print the unique string. 
    Use loop in the python.
    """
    if not isinstance(input_string, str):
        return "Invalid input. Please provide a string."
        
    result = ""
    # Use a loop as instructed
    for char in input_string:
        if char not in result:
            result += char
            
    return result

if __name__ == "__main__":
    # Test cases
    test_str_1 = "programming"
    print(f'Original: "{test_str_1}" | Unique: "{remove_duplicates(test_str_1)}"')
    
    test_str_2 = "hello world"
    print(f'Original: "{test_str_2}" | Unique: "{remove_duplicates(test_str_2)}"')
