def convert_minutes(total_minutes):
    """
    Given number of minutes, convert it into human readable form.
    Example :
    130 becomes "2 hrs 10 minutes"
    110 becomes "1hr 50minutes"
    """
    if not isinstance(total_minutes, int) or total_minutes < 0:
        return "Invalid input. Please provide a non-negative integer."
        
    hours = total_minutes // 60
    minutes = total_minutes % 60
    
    # Simple formatting based on assignment example output
    return f"{hours} hrs {minutes} minutes"

if __name__ == "__main__":
    # Test cases provided in assignment
    print(f'130 becomes "{convert_minutes(130)}"')
    print(f'110 becomes "{convert_minutes(110)}"')
