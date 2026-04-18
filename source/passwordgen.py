import secrets
import string
import sys

extra_symbols = "!@#$%^&(){}/*+~`"
all_chars = string.ascii_letters + string.digits + string.punctuation + extra_symbols

def generate_random_strings(count, length):
    for _ in range(count):
        yield ''.join(secrets.choice(all_chars) for _ in range(length))

def main():
    args = sys.argv[1:]
    output_file = None

    # Handle -o / --output
    if "-o" in args:
        idx = args.index("-o")
        output_file = args[idx + 1]
        del args[idx:idx + 2]
    elif "--output" in args:
        idx = args.index("--output")
        output_file = args[idx + 1]
        del args[idx:idx + 2]

    # Handle count + length
    if len(args) == 2:
        try:
            count = int(args[0])
            length = int(args[1])
        except ValueError:
            print("Error: count and length must be integers.")
            return
    else:
        count = int(input("How many passwords do you want? "))
        length = int(input("What is the length of each password? "))

    # Output to file or print
    if output_file:
        with open(output_file, "w", encoding="utf-8") as f:
            for pwd in generate_random_strings(count, length):
                f.write(pwd + "\n")
        print(f"Saved passwords to {output_file}")
    else:
        for pwd in generate_random_strings(count, length):
            print(pwd)

if __name__ == "__main__":
    main()


