//
//  ContentView.swift
//  Walculator
//
//  Created by Wesley Chastain on 3/12/24.
//

import SwiftUI

enum CalculatorMode2 {
    case notSet
    case addition
    case subtraction
    case multiplication
    case division
    case squareRoot
    case square
    case random
}

enum SpecialNumbers2 {
    case classic
    case pi
}

enum CalculatorModeSpecial2 {
    case notSet
    case negitaveToggle
}


struct BasicBlackCalc: View {
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
    @Environment(\.presentationMode) var presentationMode
    
    func backTo() {
        presentationMode.wrappedValue.dismiss()
    }
    
    var body: some View {
        ZStack {
            Color(.black)
            VStack {
                TotalTextBlack(value: currentValue)
                    .frame(alignment: .bottom)
                HStack {
                    
                    CalculatorButtonBlack(buttonText: "7", action: didPressNumber)
                    CalculatorButtonBlack(buttonText: "8", action: didPressNumber)
                    CalculatorButtonBlack(buttonText: "9", action: didPressNumber)
                    CalculatorButtonBlack(buttonText: "÷",color:Color(hue: 1.0, saturation: 0.097, brightness: 0.138),radius: 25, action: didPressMode, mode: .division)
                
                }
                HStack {
                    CalculatorButtonBlack(buttonText: "4", action: didPressNumber)
                    CalculatorButtonBlack(buttonText: "5", action: didPressNumber)
                    CalculatorButtonBlack(buttonText: "6", action: didPressNumber)
                    CalculatorButtonBlack(buttonText: "×",color:Color(hue: 1.0, saturation: 0.097, brightness: 0.138),radius: 25, action: didPressMode, mode: .multiplication)
                    
                }
                HStack {
                    CalculatorButtonBlack(buttonText: "1", action: didPressNumber)
                    CalculatorButtonBlack(buttonText: "2", action: didPressNumber)
                    CalculatorButtonBlack(buttonText: "3", action: didPressNumber)
                    CalculatorButtonBlack(buttonText: "-",color:Color(hue: 1.0, saturation: 0.097, brightness: 0.138),radius: 25, action: didPressMode, mode: .subtraction)
                }
                HStack {
                    CalculatorButtonBlack(buttonText: "C",color: Color(hue: 1.0, saturation: 0.59, brightness: 0.258), action: didPressModeClear)
                    CalculatorButtonBlack(buttonText: "0", action: didPressNumber)
                    CalculatorButtonBlack(buttonText: "+",color:Color(hue: 1.0, saturation: 0.097, brightness: 0.138),radius: 25, action: didPressMode, mode: .addition)
                    CalculatorButtonBlack(buttonText: "=",color:Color(hue: 0.276, saturation: 0.822, brightness: 0.144),radius: 25, action: didPressModeEqual)
                }
            }
            .frame(alignment: .bottom)
        }
        .ignoresSafeArea()
        .frame(alignment: .bottom)
    }
    
    
    func moreCalcs (button: CalculatorButtonBlack){
        calOp = true
    }
    
    
    func didPressNumber(button: CalculatorButtonBlack) {
 
        if lastButtonWasMode {
            lastButtonWasMode = false
            currentValueInt = 0
        }
        let buttonPressed = button.buttonText
        numberValueSpecialChar = button.numberValue
        if let parsedValue = Int("\(Int(currentValueInt))"+buttonPressed) {
            decimalNeeded = false // decimal is no Doubleer needed. This means a decimal doesn't need to be added as a string because it is added as a initiger instead.
            variableDecimal = Int(currentValueInt)
            if decimalFar {
                currentValueInt = Double(parsedValue)*0.1
            }
            else {
                currentValueInt = Double(parsedValue)
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
    }
    
    func didPressMode(button: CalculatorButtonBlack) {
        decimalFar = false
        decimalNeeded = false
        currentMode = button.mode
        lastButtonWasMode = true
        
        if currentMode == .squareRoot || currentMode == .square || currentMode == .random {
            lastButtonWasMode = false
        }
    }
    
    func didPressModeSpecial(button: CalculatorButtonBlack) {
        decimalFar = false
        decimalNeeded = false
        currentModeSpecial = button.modeSpecial
        
        if currentModeSpecial == .negitaveToggle {
            currentValueInt *= -1
            updateText()
        }
    }
    
    func didPressModeEqual(button: CalculatorButtonBlack) {
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
        else if currentMode == .squareRoot {
            savedNum = Double(currentValueInt).squareRoot()
        }
        else if currentMode == .square {
            savedNum = Double(currentValueInt)*Double(currentValueInt)
        }
        else if currentMode == .random {
            savedNum = Double.random(in: 0...100)
        }
        
        currentValueInt = Double(savedNum) // sending the calculated value to the current value Int. This is the variable that is displayed at the text field display.
        updateText()
        lastButtonWasMode = true

    }
    
    func didPressModeClear(button: CalculatorButtonBlack) {
        // clear button
        currentValue = "0"
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

    }
}


#Preview {
    BasicBlackCalc()
}

