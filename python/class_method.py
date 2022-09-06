class Employee:
    company = "seasia"
    salary = 10000
    salarybonus = 5000
    #totalsalary =15000

    @property
    def totalsalary(self):
        return self.salary + self.salarybonus

e = Employee()
print(e.totalsalary)