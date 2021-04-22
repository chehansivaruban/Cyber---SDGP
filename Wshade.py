import math

from Prerdiction import Prediction


class Wshade:
    def __init__(self, irradiance, clientCapacity, inputCapacity,inputTotalArea,inputOnePanelArea,inputOnePanelCapacity):
        self.irradiance=irradiance
        self.clientCapacity=clientCapacity
        self.inputCapacity=inputCapacity
        self.inputTotalArea=inputTotalArea
        self.inputOnePanelArea=inputOnePanelArea
        self.inputOnePanelCapacity=inputOnePanelCapacity

    def getUnits(self):
        if self.clientCapacity:
            capacity = self.inputCapacity
        else:
            capacity = (self.inputTotalArea / self.inputOnePanelArea) * self.inputOnePanelCapacity / 1000

        efficiencyArray = []
        j=0
        for i in self.irradiance:
            # Equation of solar panel efficiency vs irradiance graph is y = 11.092*ln(x) + 23.38
            eff = round((11.092 * math.log(i)) + 23.38, 2)
            efficiencyArray.insert(j,eff)
            j=j+1
            # print('Efficiency of solar panel ', f"{eff}%")

            # Energy = Capacity x hours x efficiency (kWh)
        print(efficiencyArray)
        totalEnergy = 0
        for i in efficiencyArray:
            energy = round(capacity * i / 100, 2)
            totalEnergy = totalEnergy+energy

        print('Produced energy ', f"{totalEnergy}kWh")

date = "2020-11-06"
startTime = "1:30:00"
endTime = "15:30:00"
clientCapacity = True
inputCapacity = 5
inputTotalArea=40
inputOnePanelCapacity=0
inputOnePanelArea=0
p1 = Prediction(date, startTime,endTime)
irr = p1.getIrradiance()
pro = Wshade(irr,clientCapacity, inputCapacity,inputTotalArea,inputOnePanelArea,inputOnePanelCapacity)
unit = pro.getUnits()







