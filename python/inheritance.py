class Employee:
    company = "seasia"

    def showDetails(self):
        print("This is an Employee")

class Programmer(Employee):
    language = "Python"
    company = "Moogle labs"

    def getlanguage(self):
        print(f"The language is {self.language}")

    def showDetails(self):
        print("This is a Programmer")

e = Employee()
e.showDetails()
p = Programmer()
p.showDetails()
print(p.company)