import calculator
def main():
    try:
        num1 = float(input("Enter your first number: "))
        num2 = float(input("Enter your second number: "))

        print("\nSelect an operation\n")
        print("1. Addition")
        print("2. Subtraction")
        print("3. Multiplication")
        print("4. Division")

        choice = input("\nEnter your choice: ")
        if choice == "1":
            return calculator.addition(num1, num2)
        elif choice == "2":
            return calculator.subtraction(num1, num2)
        elif choice == "3":
            return calculator.multiplication(num1, num2)
        elif choice == "4":
            return calculator.division(num1, num2)
        else:
            print("Invalid choice")
    except ValueError:
        print("Invalid input. Please enter a number.")
    except ZeroDivisionError:
        print("Error: cannot be divided by zero")

if __name__ == "__main__":
    result = main()
    if result is not None:
        print(f"Result: {result}")