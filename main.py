import Calculator

def main():
    print("...Math Calculator Module...")

    try:
        num1 = float(input("Enter your first number: "))
        num2 = float(input("Enter your second number: "))

        print("\nSelect an operation\n")
        print("1. Addition")
        print("2. Subtraction")
        print("3. Multiplication")
        print("4. Division")

        choice = input("Enter your choice")

        if choice == "1":
            result = Calculator.addition(num1, num2)
        elif choice == "2":
            result = Calculator.subtraction(num1, num2)
        elif choice == "3":
            result = Calculator.multiplication(num1, num2)
        elif choice == "4":
            result = Calculator.division(num1, num2)
        else:
            print("Invalid choice")
        print("Result:", result)

    except ValueError:
        print("Please enter valid numbers")
if __name__ == "__main__":
    main()
