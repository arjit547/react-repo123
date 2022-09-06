str1 = input("Please Enter your Own String : ")
alphabets = digits = special = 0

for i in range(len(str1)):
    if((str1[i] >= 'a' and str1[i] <= 'z') or (str1[i] >= 'A' and str1[i] <= 'Z')): 
        alphabets = alphabets + 1 
    elif(str1[i] >= '0' and str1[i] <= '9'):
        digits = digits + 1
    else:
        special = special + 1
        
print("\nTotal Number of Alphabets in this String :  ", alphabets)
print("Total Number of Digits in this String :  ", digits)
print("Total Number of Special Characters in this String :  ", special)