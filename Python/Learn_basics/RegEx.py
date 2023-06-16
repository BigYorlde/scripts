import re

mytext = "vasya55325@mail.ru, kolya32@yandex.ru, Vanya123@intel.com, petya55555550@rambler.ru, " \
         "john@yahoo.com"

"""
\d  = Any Digit 0-9
\D  = Any non-Digit
\w  = Any Alphabet symbol  [A-Z a-z)
\W  = Any non Alphabet symbol
\s  = backspace
\S  = non backspace

{?!vasya.com}  = Исключения из маски
[0-9]{3}  = Three digits 0-9
[A-Z][a-z]+  = The first word has uppercase and next words are lowcases.
"""

#Ищем по маске
looking_for_text = r"petya@intel.ru"
all_results = re.findall(looking_for_text, mytext)

print(all_results)