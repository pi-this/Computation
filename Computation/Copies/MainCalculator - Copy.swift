//
//  MainCalculator - Copy.swift
//  Computation
//
//  Created by Wesley Chastain on 4/2/24.
//

import SwiftUI

struct MainCalculator___Copy: View {
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
    var body: some View {
        ZStack {
            Color(.black)
            VStack {
                TotalText(value: currentValue)
                    .frame(alignment: .bottom)
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
                    CalculatorButton(buttonText: "÷",color:.blue,radius: 25, action: didPressMode, mode: .division)
                }
                HStack {
                    CalculatorButton(buttonText: "7", action: didPressNumber)
                    CalculatorButton(buttonText: "8", action: didPressNumber)
                    CalculatorButton(buttonText: "9", action: didPressNumber)
                    CalculatorButton(buttonText: "×",color:.blue,radius: 25, action: didPressMode, mode: .multiplication)
                }
                HStack {
                    CalculatorButton(buttonText: "4", action: didPressNumber)
                    CalculatorButton(buttonText: "5", action: didPressNumber)
                    CalculatorButton(buttonText: "6", action: didPressNumber)
                    CalculatorButton(buttonText: "-",color:.blue,radius: 25, action: didPressMode, mode: .subtraction)
                }
                HStack {
                    CalculatorButton(buttonText: "1", action: didPressNumber)
                    CalculatorButton(buttonText: "2", action: didPressNumber)
                    CalculatorButton(buttonText: "3", action: didPressNumber)
                    CalculatorButton(buttonText: "+",color:.blue,radius: 25, action: didPressMode, mode: .addition)
                }
                HStack {
                    CalculatorButton(buttonText: "0", action: didPressNumber)
                    CalculatorButton(buttonText: "00", textSize: 26, action: didPressNumber)
                    CalculatorButton(buttonText: ".", action: didPressNumber)
                    CalculatorButton(buttonText: "=",color:.blue,radius: 25, action: didPressModeEqual)
                }
            }
            .frame(alignment: .bottom)
        }
        .ignoresSafeArea()
        .frame(alignment: .bottom)
    }
    
    
    func didPressNumber(button: CalculatorButton) {
        
        if lastButtonWasMode {
            lastButtonWasMode = false
            currentValueInt = 0
        }
        let buttonPressed = button.buttonText
        numberValueSpecialChar = button.numberValue
        if decimalHiddenValue == 0 {
            decimalHiddenValue = Int(currentValueInt)
        }
        currentValueIntThis = Int(Double(decimalHiddenValue))
        if let parsedValue = Int("\(Int(currentValueIntThis))"+buttonPressed) {
            decimalNeeded = false // decimal is no Doubleer needed. This means a decimal doesn't need to be added as a string because it is added as a initiger instead.
            variableDecimal = Int(currentValueInt)
            if decimalFar {
                if buttonPressed == "0" && currentValueIntThis == 0 {
                    zeroValueDecimal = true
                    decimalPlaceTimes = 1
                }
                else if buttonPressed == "0" && currentValueIntThis != 0 {
                    if !doneThat2decimal {
                        otherNumberValueDecimalWithZeroException = true
                        decimalPlaceTimes = 1
                    }
                }
                else {
                    decimalPlaceTimes += 1
                    if decimalPlaceTimes == 1 {
                        // only stored once, only done possilbly once. (disregarding the clear button ofcource)
                        storedInt = currentValueIntThis
                        currentValueInt = Double(storedInt)+(Double(parsedValue)*0.1)-Double(storedInt)
                        decimalHiddenValue = Int(buttonPressed) ?? 0
                        doneThat2decimal = true
                        updateText()
                        
                        
                        // !! Having issues with this:
                        // do not take away but modify
                        if currentMode == .notSet || lastButtonWasMode {
                            return
                        }
                        else if currentMode == .addition {
                            savedNum += Double(currentValueInt)
                            lastOperation = "add"
                            lastIntWithLoDec = Double(currentValueInt)
                        }
                        else if currentMode == .subtraction {
                            savedNum -= Double(currentValueInt)
                            lastOperation = "subtract"
                            lastIntWithLoDec = Double(currentValueInt)
                        }
                        else if currentMode == .division {
                            savedNum /= Double(currentValueInt)
                            lastOperation = "divide"
                            lastIntWithLoDec = Double(currentValueInt)
                        }
                        else if currentMode == .multiplication {
                            savedNum *= Double(currentValueInt)
                            lastOperation = "multiply"
                            lastIntWithLoDec = Double(currentValueInt)
                        }
                    }
                    else if decimalPlaceTimes == 2 {
                        if buttonPressed != "00" {
                            storedInt2 = storedInt
                            storedInt = currentValueIntThis
                            if zeroThing{
                                currentValueInt = Double(storedInt)+Double(storedInt2)*0.1+Double(parsedValue)*0.01-(Double(storedInt)*0.1)
                                decimalHiddenValue = Int(buttonPressed) ?? 0
                                updateText()
                            }
                            else {
                                currentValueInt = Double(storedInt2)+Double(storedInt)*0.1+Double(parsedValue)*0.01-(Double(storedInt)*0.1)
                                decimalHiddenValue = Int(buttonPressed) ?? 0
                                updateText()
                            } // adds a second decimal number
                            
                            doneThat2decimal = true
                            
                            
                            

                        }
                    }
                }
            }
            else {
                currentValueInt = Double(parsedValue)
                decimalHiddenValue = Int(currentValueInt)
                updateText()
            }
        }
        else if buttonPressed == "." {
                decimalFar = true
                decimalNeeded = true
                updateText()
        }
        else {
            currentValue = "Error"
            currentValueInt = 0
        }
        
        if !decimalFar {
            lastOperation = ""
            lastIntWithLo = 0
            lastIntWithLoDec = 0

            if currentMode == .notSet || lastButtonWasMode {
                return
            }
            else if currentMode == .addition {
                savedNum += Double(currentValueInt)
                lastOperation = "add"
                lastIntWithLo = Double(Int(currentValueInt))
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
            if currentMode == .addition {
                clearScreen = true
            }
            else if currentMode == .subtraction {
                clearScreen = true
            }
            else if currentMode == .division {
                clearScreen = true
            }
            else if currentMode == .multiplication {
                clearScreen = true
            }
            
            currentValueInt = Double(savedNum) // sending the calculated value to the current value Int. This is the variable that is displayed at the text field display.
            updateText()

            
            // clearing the number values for decimal use
            // nessasary for restarting the way numbers are inputed, data is not cleared compleatly. This only allows numbers to be inputed currectly.
            decimalPlaceTimes = 0
            decimalHiddenValue = 0
        }

    }
    
    func didPressModeSpecial(button: CalculatorButton) {
        decimalFar = false
        decimalNeeded = false
        currentModeSpecial = button.modeSpecial
        
        if currentModeSpecial == .negitaveToggle {
            currentValueInt *= -1
            updateText()
        }
        else if currentModeSpecial == .percent {
            currentValueInt *= 0.01
            updateText()
        }
    }
    
    func didPressModeEqual(button: CalculatorButton) {
        updateText()
        if decimalFar {
            if lastOperation == "add" {
                savedNum -= Double(lastIntWithLo)
            }
            else if lastOperation == "subtract" {
                savedNum += Double(lastIntWithLo)
            }
            else if lastOperation == "divide" {
                savedNum *= Double(lastIntWithLo)
            }
            else if lastOperation == "multiply" {
                savedNum /= Double(lastIntWithLo)
            }
            
            
        }
        currentValueInt = Double(savedNum) // sending the calculated value to the current value Int. This is the variable that is displayed at the text field display.
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
            savedNum = Double(currentValueInt)
        }
        
        let numberFormatter = NumberFormatter()
        let num = NSNumber(value: currentValueInt)
        numberFormatter.numberStyle = .decimal
      
        
        currentValue = numberFormatter.string(from: num) ?? "Error"
        if decimalFar && decimalNeeded {
            currentValue += "."
        }
        else if zeroValueDecimal {
            currentValue = "0.0"
            zeroValueDecimal = false
        }
        else if otherNumberValueDecimalWithZeroException{
            currentValue = "\(decimalHiddenValue).0"
            otherNumberValueDecimalWithZeroException = false
            zeroThing = true
        }
        else if clearScreen {
            currentValue = "0"
            clearScreen = false
            decimalFar = false
        }

    }
}

#Preview {
    MainCalculator___Copy()
}
