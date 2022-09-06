import re



input_file_path = "files/data.html"
output_file_path = "files/result_data.txt"

input_file = open(input_file_path, mode='r', encoding="Latin_1")
output_file = open(output_file_path, mode='w', encoding="Latin_1")


look_for = r"[\w.]+@[A-z0-9.]+"

my_text = input_file.read()

results = re.findall(look_for, my_text)

for element in results:
    print(element)
    output_file.write(f"{element} \n")

