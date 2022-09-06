class Employee:
    company = "Goggle"
    salary = 100
Arjit = Employee()
Ankit = Employee()
Arjit.salary = 300
#Ankit.salary = 250
print(Arjit.company)
print(Ankit.company)
Employee.company = "seasia"
print(Arjit.company)
print(Ankit.company)
print(Arjit.salary)
print(Ankit.salary)