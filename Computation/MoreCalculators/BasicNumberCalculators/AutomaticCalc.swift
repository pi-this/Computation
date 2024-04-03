//
//  ContentView.swift
//  Walculator
//
//  Created by Wesley Chastain on 3/12/24.
//

import SwiftUI

enum CalculatorMode3 {
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

enum SpecialNumbers3 {
    case classic
}

enum CalculatorModeSpecial3 {
    // this is special because it operates without the equal button being pressed
    case notSet
    case negitaveToggle
    case percent
}


struct AutomaticCalc: View {
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
    @State var orginNum:Double = 0
    var body: some View {
        ZStack {
            Color(.black)
            VStack {
                TotalTextBlack(value: currentValue)
                    .frame(alignment: .bottom)
                HStack {
                    
                    CalculatorButtonBlack(buttonText: "7", color: Color(hue: 0.584, saturation: 0.602, brightness: 0.53), action: didPressNumber)
                    CalculatorButtonBlack(buttonText: "8",color: Color(hue: 0.584, saturation: 0.602, brightness: 0.53), action: didPressNumber)
                    CalculatorButtonBlack(buttonText: "9",color: Color(hue: 0.584, saturation: 0.602, brightness: 0.53), action: didPressNumber)
                    CalculatorButtonBlack(buttonText: "÷",color:Color(hue: 1.0, saturation: 0.097, brightness: 0.125),radius: 25, action: didPressMode, mode: .division)
                
                }
                HStack {
                    CalculatorButtonBlack(buttonText: "4",color: Color(hue: 0.584, saturation: 0.602, brightness: 0.53), action: didPressNumber)
                    CalculatorButtonBlack(buttonText: "5",color: Color(hue: 0.584, saturation: 0.602, brightness: 0.53), action: didPressNumber)
                    CalculatorButtonBlack(buttonText: "6",color: Color(hue: 0.584, saturation: 0.602, brightness: 0.53), action: didPressNumber)
                    CalculatorButtonBlack(buttonText: "×",color:Color(hue: 0.348, saturation: 0.813, brightness: 0.583),radius: 25, action: didPressMode, mode: .multiplication)
                    
                }
                HStack {
                    CalculatorButtonBlack(buttonText: "1",color: Color(hue: 0.584, saturation: 0.602, brightness: 0.53), action: didPressNumber)
                    CalculatorButtonBlack(buttonText: "2",color: Color(hue: 0.584, saturation: 0.602, brightness: 0.53), action: didPressNumber)
                    CalculatorButtonBlack(buttonText: "3",color: Color(hue: 0.584, saturation: 0.602, brightness: 0.53), action: didPressNumber)
                    CalculatorButtonBlack(buttonText: "-",color:Color(hue: 0.405, saturation: 0.177, brightness: 0.132),radius: 25, action: didPressMode, mode: .subtraction)
                }
                HStack {
                    CalculatorButtonBlack(buttonText: "C",color: Color(hue: 0.001, saturation: 0.727, brightness: 0.518), action: didPressModeClear)
                    CalculatorButtonBlack(buttonText: "0", color: Color(hue: 0.584, saturation: 0.0, brightness: 0.033),action: didPressNumber)
                    CalculatorButtonBlack(buttonText: "+",color:Color(hue: 0.343, saturation: 0.794, brightness: 0.196),radius: 25, action: didPressMode, mode: .addition)
                    CalculatorButtonBlack(buttonText: "=",color:Color(hue: 0.276, saturation: 0.861, brightness: 0.424),radius: 25, action: didPressModeEqual)
                }
            }
            .frame(alignment: .bottom)
        }
        .ignoresSafeArea()
        .frame(alignment: .bottom)
    }

    
    
    func didPressNumber(button: CalculatorButtonBlack) {
        
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
                    }
                    else if decimalPlaceTimes == 2 {
                        if buttonPressed != "00" {
                            storedInt2 = storedInt
                            storedInt = currentValueIntThis
                            if zeroThing {
                                currentValueInt = Double(storedInt)+Double(storedInt2)*0.1+Double(parsedValue)*0.01-(Double(storedInt)*0.1)
                                decimalHiddenValue = Int(buttonPressed) ?? 0
                            }
                            else {
                                currentValueInt = Double(storedInt2)+Double(storedInt)*0.1+Double(parsedValue)*0.01-(Double(storedInt)*0.1)
                                decimalHiddenValue = Int(buttonPressed) ?? 0
                            }
                            doneThat2decimal = true
                        }
                    }
                }
            }
            else {
                currentValueInt = Double(parsedValue)
                decimalHiddenValue = Int(currentValueInt)
            }
            updateText()
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
        
            updateText()
            orginNum = currentValueInt
            if currentMode == .notSet || lastButtonWasMode {
                return
            }
            else if currentMode == .addition {
                savedNum += Double(currentValueInt)
            }
            else if currentMode == .subtraction {
                savedNum -= Double(currentValueInt)
            }
            else if currentMode == .division {
                savedNum /= Double(currentValueInt)
            }
            else if currentMode == .multiplication {
                savedNum *= Double(currentValueInt)
            }
            
            currentValueInt = Double(savedNum) // sending the calculated value to the current value Int. This is the variable that is displayed at the text field display.
            
            updateText()

    }
    
    func didPressMode(button: CalculatorButtonBlack) {
        decimalFar = false
        decimalNeeded = false
        currentMode = button.mode
        lastButtonWasMode = true
        
        if currentMode == .squareRoot || currentMode == .square || currentMode == .random || currentMode == .pi {
            lastButtonWasMode = false
        }
        
        // clearing the number values for decimal use
        // nessasary for restarting the way numbers are inputed, data is not cleared compleatly. This only allows numbers to be inputed currectly.
        decimalPlaceTimes = 0
        decimalHiddenValue = 0
        currentValueIntThis = 0
        storedInt = 0
        zeroThing = false
        
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
        
        else if currentMode == .addition {
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
        lastButtonWasMode = true
        
        // clearing the number values for decimal use
        // nessasary for restarting the way numbers are inputed, data is not cleared compleatly. This only allows numbers to be inputed currectly.
        decimalPlaceTimes = 0
        decimalHiddenValue = 0
        currentValueIntThis = 0
        storedInt = 0
        zeroThing = false

    }
    
    func didPressModeSpecial(button: CalculatorButtonBlack) {
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
    
    func didPressModeEqual(button: CalculatorButtonBlack) {
            if currentMode == .notSet || lastButtonWasMode {
                return
            }
            else if currentMode == .addition {
                savedNum += Double(orginNum)
                currentMode = .addition
            }
            else if currentMode == .subtraction {
                savedNum -= Double(currentValueInt)
            }
            else if currentMode == .division {
                savedNum /= Double(currentValueInt)
            }
            else if currentMode == .multiplication {
                savedNum *= Double(savedNum)
            }
        
        currentValueInt = Double(savedNum) // sending the calculated value to the current value Int. This is the variable that is displayed at the text field display.
        updateText()


    }
    
    func didPressModeClear(button: CalculatorButtonBlack) {
        // clear button
        
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
            currentValue = ""
            clearScreen = false
            decimalFar = false
        }

    }
}


#Preview {
    AutomaticCalc()
}

