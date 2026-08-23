while True:
    try:
        num1 = float(input("Enter your first number: "))
        num2 = float(input("Enter your second number: "))

        result = num1 / num2
        print("Result:", result)
        break
    except ValueError:
        print("\nError: Please enter only numbers\n")
    except ZeroDivisionError:
        print("\nError: Please enter a non-zero second number\n")