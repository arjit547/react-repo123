string = input("Enter the strings :")
alphabets = 0
digits = 0
specialChars=0

for i in string:
    if i.isalpha():
        alphabets+=1

    elif i.isdigit():
        digits+=1

    else:
        specialChars+=1

print("alphabets = ", alphabets, "digits = ", digits , "specialChars = ", specialChars)

