//
//  CalculatorButton.swift
//  Walculator
//
//  Created by Wesley Chastain on 3/12/24.
//

import SwiftUI

struct CalculatorButtonBlack: View {
    var buttonText: String = "1"
    var color: Color = Color(hue: 1.0, saturation: 0.0, brightness: 0.248)
    var radius = 50
    var textSize = 50
    var width: CGFloat = 80
    var height: CGFloat = 80
    var xSet = 0
    var ySet = 0
    var action: (CalculatorButtonBlack) -> Void = {_ in }
    var mode: CalculatorMode = .notSet
    var numberValue: SpecialNumbers = .classic
    var modeSpecial: CalculatorModeSpecial = .notSet
    var body: some View {
        Button{
            action(self)
        } label: {
            Text(buttonText)
                .font(.system(size: CGFloat(textSize)))
                .padding()
                .frame(width: width, height: height)
                .offset(x:CGFloat(xSet),y:CGFloat(ySet))
                .background(color)
                .foregroundColor(.white)
                .clipShape(RoundedRectangle(cornerRadius: CGFloat(radius)))
            
        }
    }

}

#Preview {
    CalculatorButton()
}
