import math
import ShadeArea
import Prediction


class Wshade:
    def __init__(self, irradiance, clientCapacity, inputCapacity,inputTotalArea,inputOnePanelArea,inputOnePanelCapacity):
        self.irradiance=irradiance
        self.clientCapacity=clientCapacity
        self.inputCapacity=float(inputCapacity)
        self.inputTotalArea=float(inputTotalArea)
        self.inputOnePanelArea=float(inputOnePanelArea)
        self.inputOnePanelCapacity=float(inputOnePanelCapacity)



    def getUnits(self):
        if self.clientCapacity:
            print("if")
            capacity = self.inputCapacity
        else:
            print("else")
            capacity = (self.inputTotalArea / self.inputOnePanelArea)*self.inputOnePanelCapacity / 1000

        efficiencyArray = []
        print(capacity)
        j=0
        print("irradiance :",self.irradiance)
        for i in self.irradiance:
            # Equation of solar panel efficiency vs irradiance graph is y = 11.092*ln(x) + 23.38
            if i==0:
                efficiencyArray.insert(j,0)
            else:
                eff = round((11.092 * math.log(i)) + 23.38, 2)
                print("done")
                efficiencyArray.insert(j, eff)

            j=j+1
            # print('Efficiency of solar panel ', f"{eff}%")

            # Energy = Capacity x hours x efficiency (kWh)
        print(efficiencyArray)
        totalEnergy = 0
        for i in efficiencyArray:
            capacity = int(capacity)
            energy = round(capacity * i / 100, 2)
            totalEnergy = totalEnergy+energy

        print('Produced energy without shading ', f"{totalEnergy}kWh")


        return totalEnergy

    def getUnitsShade(self,sArea,objs):
        if self.clientCapacity:
            capacity = self.inputCapacity
        else:
            capacity = (self.inputTotalArea / self.inputOnePanelArea) * self.inputOnePanelCapacity / 1000

        efficiencyArray = []
        shadeAreaArray = sArea
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
            capacity = int(capacity)
            energy = round(capacity * i / 100, 2)
            totalEnergy = totalEnergy+energy

        print('Produced energy without shading ', f"{totalEnergy}kWh")
        # sArea=ShadeArea( self.date, self.time,self.oLat,self.oLon)
        totalProductivity=0
        print("eff :",efficiencyArray)
        print("shadearr :",shadeAreaArray)


        for q in range(objs):
            areaEffect = ((self.inputTotalArea - shadeAreaArray[q]) / (self.inputTotalArea ))* 100
            productivity = totalEnergy * areaEffect/100
            totalProductivity = totalProductivity

        print("areaEffect :",areaEffect)


        return productivity
#
# date = "2020-11-06"
# startTime = "1:30:00"
# endTime = "15:30:00"
# clientCapacity = True
# inputCapacity = 5
# inputTotalArea=40
# inputOnePanelCapacity=0
# inputOnePanelArea=0
# p1 = Prediction(date, startTime,endTime)
# irr = p1.getIrradiance()
# pro = Wshade(irr,clientCapacity, inputCapacity,inputTotalArea,inputOnePanelArea,inputOnePanelCapacity)
# unit = pro.getUnits()







