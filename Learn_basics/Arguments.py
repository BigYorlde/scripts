import sys
import os

#print(sys.argv[1:])
#print(sys.argv[1])
#print(sys.argv[2])
#print(sys.argv[3])

len_argv = len(sys.argv)

if len_argv > 1:
    if sys.argv[1] == "/?":
        print("Help Requested")
        print("Usage of this program is: python.exe myfile.py argv1 argv2")
    print(f"Arguments entered: {str(argv[1:])}")
else:
    print("Arguments NOT PROVIDED")

os.system("dir > test.txt")
os.mkdir("my_dir")
sys.exit()