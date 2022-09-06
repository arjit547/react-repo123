from inspect import signature


class Employee:
    company = "seasia"
    def getSalary(self):
        print(f"Salary for this employee working in {self.company} is {self.salary}\
            n{signature}")
    @staticmethod
    def greet():
        print("Good Morning sir")

harry = Employee()
harry.salary = 100000
harry.getSalary() # Employee.getSalary(harry)
harry.greet()