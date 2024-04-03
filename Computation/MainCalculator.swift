//
//  ContentView.swift
//  Walculator
//
//  Created by Wesley Chastain on 3/12/24.
//

import SwiftUI

enum CalculatorMode {
    case notSet
    case addition
    case subtraction
    case multiplication
    case division
    case squareRoot
    case square
    case random
    case pi
}

enum SpecialNumbers {
    case classic
}

enum CalculatorModeSpecial {
    // this is special because it operates without the equal button being pressed
    case notSet
    case negitaveToggle
    case percent
}


struct ContentView: View {
    @State var didOnceDecimal = false
    @State var isPresenting = false
    @State var currentValue = "0"
    @State var currentMode: CalculatorMode = .notSet
    @State var currentModeSpecial: CalculatorModeSpecial = .notSet
    @State var numberValueSpecialChar: SpecialNumbers = .classic
    @State var lastButtonWasMode = false
    @State var savedNum: Double = 0
    @State var currentValueInt: Double = 0
    @State var decimalFar = false // this defines if a whole number will or will not be used. It starts as a whole number
    @State var decimalNeeded = false
    @State var decimalNumberPressed: Double = 0
    @State var variableDecimal = 0
    @State var calOp = false
    @State var see = true
    @State var decimalPlaceTimes = 0
    @State var decimalHiddenValue = 0
    @State var currentValueIntThis = 0
    @State var storedInt = 0
    @State var zeroValueDecimal = false
    @State var otherNumberValueDecimalWithZeroException = false
    @State var zeroThing = false
    @State var storedInt2 = 0
    @State var doneThat2decimal = false
    @State var doneThat1decimal = false
    @State var clearScreen = false
    @State var lastOperation = ""
    @State var lastIntWithLo:Double = 0
    @State var lastIntWithLoDec:Double = 0
    @State var doneCount = 0
    @State var againAgain = 0
    @State var aDoperationColor: Color = .blue
    @State var aMoperationColor: Color = .blue
    @State var aSoperationColor: Color = .blue
    @State var aAoperationColor: Color = .blue
    @State var printInfo: String = ">  ?  <"
    @State var printInfo2: String = ">  ?  <"
    @State var printInfo3: String = ">  ?  <"
    @State var printInfo4: String = ">  ?  <"
    @State var cPar: Double = 0
    var body: some View {
        ZStack {
            Color(.black)
            VStack {
                TotalText(value: currentValue)
                    .frame(alignment: .bottom)
                Text(printInfo)
                Text(printInfo2)
                Text(printInfo3)
                Text(printInfo4)
                HStack {
                    CalculatorButton(buttonText: "C",color: Color(hue: 1.0, saturation: 0.706, brightness: 0.785), action: didPressModeClear)
                    CalculatorButton(buttonText: "?",color: Color(hue: 1.0,saturation: 0.0, brightness: 0.503), action: didPressMode, mode: .random)
                    CalculatorButton(buttonText: "√",color:Color(hue: 0.587, saturation: 0.973, brightness: 0.743),radius: 25,textSize: 25, action: didPressMode, mode: .squareRoot)
                    CalculatorButton(buttonText: "x²",color:Color(hue: 0.587, saturation: 0.973, brightness: 0.743),radius: 25,textSize: 30, action: didPressMode, mode: .square)
                }
                HStack {
                    CalculatorButton(buttonText: "±", color: Color(hue: 0.021, saturation: 0.0, brightness: 0.458), radius: 30, textSize: 25, action: didPressModeSpecial, modeSpecial: .negitaveToggle)
                    CalculatorButton(buttonText: "%", color: Color(hue: 0.021, saturation: 0.0, brightness: 0.458), radius: 30, textSize: 30, action: didPressModeSpecial, modeSpecial: .percent)
                    CalculatorButton(buttonText: "π", color: Color(hue: 0.021, saturation: 0.0, brightness: 0.458), radius: 30, textSize: 35, action: didPressMode, mode: .pi)
                    CalculatorButton(buttonText: "÷",color:aDoperationColor,radius: 25, action: didPressMode, mode: .division)
                }
                HStack {
                    CalculatorButton(buttonText: "7", action: didPressNumber)
                    CalculatorButton(buttonText: "8", action: didPressNumber)
                    CalculatorButton(buttonText: "9", action: didPressNumber)
                    CalculatorButton(buttonText: "×",color:aMoperationColor,radius: 25, action: didPressMode, mode: .multiplication)
                }
                HStack {
                    CalculatorButton(buttonText: "4", action: didPressNumber)
                    CalculatorButton(buttonText: "5", action: didPressNumber)
                    CalculatorButton(buttonText: "6", action: didPressNumber)
                    CalculatorButton(buttonText: "-",color:aSoperationColor,radius: 25, action: didPressMode, mode: .subtraction)
                }
                HStack {
                    CalculatorButton(buttonText: "1", action: didPressNumber)
                    CalculatorButton(buttonText: "2", action: didPressNumber)
                    CalculatorButton(buttonText: "3", action: didPressNumber)
                    CalculatorButton(buttonText: "+",color:aAoperationColor,radius: 25, action: didPressMode, mode: .addition)
                }
                HStack {
                    CalculatorButton(buttonText: "0", action: didPressNumber)
                    CalculatorButton(buttonText: "00", textSize: 26, action: didPressNumber)
                    CalculatorButton(buttonText: ".", action: didPressNumber)
                    CalculatorButton(buttonText: "=",color:Color(hue: 0.595, saturation: 0.561, brightness: 0.624),radius: 25, action: didPressModeEqual)
                }
            }
            .frame(alignment: .bottom)
        }
        .ignoresSafeArea()
        .frame(alignment: .bottom)
    }
    
    
    func didPressNumber(button: CalculatorButton) {
        // reset all operations when a number is pressed
        aDoperationColor = .blue
        aMoperationColor = .blue
        aSoperationColor = .blue
        aAoperationColor = .blue
        
        if lastButtonWasMode {
            lastButtonWasMode = false  
            currentValueInt = 0
        }
        let buttonPressed = button.buttonText
        numberValueSpecialChar = button.numberValue
        if buttonPressed == "." {
            decimalFar = true
            decimalNeeded = true
            updateText()
        }
        else if !decimalFar {
            if let parsedValue = Double("\(Int(currentValueInt))"+buttonPressed) {
                cPar = parsedValue
                decimalNeeded = false // decimal is no Doubleer needed. This means a decimal doesn't need to be added as a string because it is added as a initiger instead.
                if decimalFar == true {
                    currentValueInt = parsedValue*100 // if using a decimal do 10 not 100
                }
                else {
                    currentValueInt = parsedValue // makes it so the number does not have all thoes 0s when using the double
                }
                    updateText()
            }
            else {
                currentValue = "Error"
                currentValueInt = 0
            }
        }
        else if decimalFar {
            if !didOnceDecimal {
                decimalNeeded = false
                if let parsedValue = Double("\(Int(currentValueInt))"+"."+buttonPressed) {
                    cPar = parsedValue
                    didOnceDecimal = true // if the decimal value was once done then use double in future
                    currentValueInt = parsedValue
                    updateText()
                }
                else {
                    currentValue = "Error"
                    currentValueInt = 0
                }
            }
            else {
                decimalNeeded = false
                if let parsedValue = Double("\(currentValueInt)"+buttonPressed) {
                    cPar = parsedValue
                    didOnceDecimal = true // if the decimal value was once done then use double in future
                    currentValueInt = parsedValue
                    updateText()
                }
                else {
                    currentValue = "Error"
                    currentValueInt = 0
                }
            }
        }
        
        if buttonPressed != "." {
            lastOperation = ""
            lastIntWithLo = 0
            lastIntWithLoDec = 0

            if currentMode == .notSet || lastButtonWasMode {
                return
            }
            else if currentMode == .addition {
                savedNum += currentValueInt
                lastOperation = "add"
            }
            else if currentMode == .subtraction {
                savedNum -= Double(currentValueInt)
                lastOperation = "subtract"
                lastIntWithLo = Double(Int(currentValueInt))
            }
            else if currentMode == .division {
                savedNum /= Double(currentValueInt)
                lastOperation = "divide"
                lastIntWithLo = Double(Int(currentValueInt))
            }
            else if currentMode == .multiplication {
                savedNum *= Double(currentValueInt)
                lastOperation = "multiply"
                lastIntWithLo = Double(Int(currentValueInt))
            }
        }

    }
    
    func didPressMode(button: CalculatorButton) {
        didOnceDecimal = false // for decimals to work. It resets the decimal push
        // big isues with decimals
        decimalFar = false
        currentMode = button.mode
        lastButtonWasMode = true
        
        if currentMode == .squareRoot || currentMode == .square || currentMode == .random || currentMode == .pi {
            lastButtonWasMode = false
        }
        
        if currentMode == .squareRoot {
            savedNum = Double(currentValueInt).squareRoot()
        }
        else if currentMode == .square {
            savedNum = Double(currentValueInt)*Double(currentValueInt)
        }
        else if currentMode == .random {
            savedNum = Double.random(in: 0...100)
        }
        else if currentMode == .pi {
            savedNum = Double(3.141592653589793238462)
        }
        
        if !decimalFar {
            
            // changes button color of operation when it it in use
            if currentMode == .addition {
                aAoperationColor = .green
                aSoperationColor = .blue
                aMoperationColor = .blue
                aDoperationColor = .blue
            }
            else if currentMode == .subtraction {
                aSoperationColor = .green
                aAoperationColor = .blue
                aMoperationColor = .blue
                aDoperationColor = .blue
            }
            else if currentMode == .division {
                aDoperationColor = .green
                aSoperationColor = .blue
                aMoperationColor = .blue
                aAoperationColor = .blue
            }
            else if currentMode == .multiplication {
                aMoperationColor = .green
                aSoperationColor = .blue
                aAoperationColor = .blue
                aDoperationColor = .blue
            }
            
            currentValueInt = savedNum // sending the calculated value to the current value Int. This is the variable that is displayed at the text field display.
            updateText()

            
            // clearing the number values for decimal use
            // nessasary for restarting the way numbers are inputed, data is not cleared compleatly. This only allows numbers to be inputed currectly.
            decimalPlaceTimes = 0
            decimalHiddenValue = 0
        }

    }
    
    func didPressModeSpecial(button: CalculatorButton) {
        didOnceDecimal = false // for decimals to work. It resets the decimal push
        decimalFar = false
        decimalNeeded = false
        currentModeSpecial = button.modeSpecial
        // isues with - negitave
        
//        if currentModeSpecial == .negitaveToggle {
//            currentValueInt *= -1
//            updateText()
//        }
//        else if currentModeSpecial == .percent {
//            currentValueInt *= 0.01
//            updateText()
//        }
    }
    
    func didPressModeEqual(button: CalculatorButton) {
        didOnceDecimal = false // for decimals to work. It resets the decimal push
        
        // set all of the operation buttons to defult color sense none are in use
        aDoperationColor = .blue
        aMoperationColor = .blue
        aSoperationColor = .blue
        aAoperationColor = .blue
        
        
        updateText()
        currentValueInt = savedNum // sending the calculated value to the current value Int. This is the variable that is displayed at the text field display.
        updateText()
        lastButtonWasMode = true
        
        // clearing the number values for decimal use
        // nessasary for restarting the way numbers are inputed, data is not cleared compleatly. This only allows numbers to be inputed currectly.
        decimalPlaceTimes = 0
        decimalHiddenValue = 0
        currentValueIntThis = 0
        storedInt = 0
        zeroThing = false

    }
    
    func didPressModeClear(button: CalculatorButton) {
        // clear button
        didOnceDecimal = false
        aDoperationColor = .blue
        aMoperationColor = .blue
        aSoperationColor = .blue
        aAoperationColor = .blue
        lastIntWithLoDec = 0
        storedInt2 = 0
        clearScreen = false
        lastOperation = ""
        lastIntWithLo = 0
        doneThat2decimal = false
        doneThat1decimal = false
        zeroThing = false
        otherNumberValueDecimalWithZeroException = false
        zeroValueDecimal = false
        storedInt = 0
        currentValueIntThis = 0
        decimalHiddenValue = 0
        currentValue = "0"
        decimalPlaceTimes = 0
        savedNum = 0
        currentValueInt = 0
        lastButtonWasMode = false
        currentMode = .notSet
        currentModeSpecial = .notSet
        decimalFar = false // clear value that tells the app if a decimal value is being used when doing calculations instead of messing with whole numbers.
        decimalNeeded = false
        decimalNumberPressed = 0
    }
    
    func updateText() {
        if currentMode == .notSet {
            savedNum = currentValueInt
        }
        
        let numberFormatter = NumberFormatter()
        let num = NSNumber(value: currentValueInt)
        numberFormatter.numberStyle = .decimal
      
        
        currentValue = numberFormatter.string(from: num) ?? "Error"
        if decimalFar && decimalNeeded {
            currentValue += "."
        }
        printInfo = "savedNum " + String(savedNum)
        printInfo2 = "cPar " + String(cPar)
        printInfo3 = "currentValueInt " + String(currentValueInt)
        printInfo4 = "currentValue " + String(currentValue)

    }
}


#Preview {
    ContentView()
}

