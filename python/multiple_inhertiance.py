class Employee:
    company = "seasia"

class Freelancer:
    company = "visa"
    level =0

class Programmer(Freelancer,Employee ):
    name = "Arjit" 

p = Programmer()
print(p.company)
