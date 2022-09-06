class Train:
    def __init__(self, name, fare, seats):
        self.name = name
        self.fare = fare
        self.seats = seats

    def getStatus(self):
         print(f"The name of the train is {self.name}")
         print(f"The seats available in the train are {self.seats}")

    def fareInfo(self):
        print(f"The price of the ticket is: Rs {self.fare}")

intercity = Train("Intercity Express: 14015", 90, 2)
intercity.getstatus()
intercity.fareInfo() 