//
//  ContentView.swift
//  First App
//
//  Created by Wesley Chastain on 3/1/24.
//

import SwiftUI

struct TipCalc: View {
    @State var total = "100"
    @State var tipPercent = 15.0
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "dollarsign")
                    .imageScale(.large)
                .foregroundStyle(.tint)
                .font(/*@START_MENU_TOKEN@*/.title2/*@END_MENU_TOKEN@*/)
                Text("Tip Calculator")
                    .font(.largeTitle)
                    .fontWeight(.heavy)
            }
            HStack {
                Text("$")
                TextField("Amount", text: $total)
            }
            
            HStack {
                Slider(value: $tipPercent, in: 1...100, step: 1.0)
                Text("\(Int(tipPercent))")
                Text("%")
            }
            if let totalNumber = Double(total) {
                Text("Tip Amount: $\(totalNumber * tipPercent / 100, specifier: "%0.2f")")
            }
            else {
                Text("Please enter a numeric value.")
            }
          
            
        }
        .padding()
    }
}

#Preview {
    TipCalc()
}
