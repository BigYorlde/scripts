calculation_to_units = 24
name_of_unit = "hours"


def days_to_units(num_of_days):
        return f'{num_of_days} days are {num_of_days * calculation_to_units} ' \
               f'{name_of_unit}'


def validate_and_execute():
    try:
        user_input_number = int(num_of_days_element)
        # we want to do conversion only for positive integers
        if user_input_number > 0:
            calculated_value = days_to_units(user_input_number)
            print(calculated_value)
        elif user_input_number == 0:
            print("You entered a 0, please enter a valid positive number!")
        else:
            print("You entered a negative number, no conversion for you!")
    except ValueError:
        print("Your input is not a valid number. Don't ruin my program!")


user_input = ""
while user_input != 'exit':
    user_input = input("Hey user, enter a number of days as a comma separated "
                       "and I will convert it to hours!\n")
    list_of_days = user_input.split(", ")
    #print(list_of_days)
    #print(set(list_of_days))

    #print(type(list_of_days))
    #print(type(set(list_of_days)))

    #print(type(user_input.split(", ")))
    #print(user_input.split(", "))

    for num_of_days_element in set(user_input.split(", ")): #set нужен для дедубликации
        validate_and_execute()

print("some text")
input("enter value")
set([1, 3, 4])
int("20")

"2, 3".split()
[1, 3, 4].count()






