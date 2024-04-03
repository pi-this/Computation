//
//  CurrencyConverter.swift
//  Computation
//
//  Created by Wesley Chastain on 3/20/24.
//

import SwiftUI

struct CurrencyConverter: View {
    @State var us = ""
    @State var china = ""
    @State var textInfo = ""
    @State var moneyThen:Double = 0
    @State var moneyConverted:Double = 0
    @State var firstMoneyType = ""
    @State var firstMoneyTypeInt = 1
    @State var secondMoneyType = ""
    @State var secondMoneyTypeInt = 1
    @State var moneyMath: Double = 0
    
    var body: some View {
        VStack {
            Text(textInfo)
            HStack {
                Picker(selection: $firstMoneyTypeInt, label: Text("Picker")) {
                    Text("China Yuan").tag(2)
                    Text("Mexican Peso").tag(3)
                    Text("South Korean won").tag(4)
                    Text("US Dollar").tag(1)
                }
                
                if firstMoneyTypeInt == 1 {
                    Text("$")
                }
                else if firstMoneyTypeInt == 2 {
                    Text("¥")
                }
                else if firstMoneyTypeInt == 3 {
                    Text("₱")
                }
                else if firstMoneyTypeInt == 4 {
                    Text("₩")
                }
                TextField("0.00", text: $us)
            }
            HStack {
                Picker(selection: $secondMoneyTypeInt, label: Text("Picker")) {
                    Text("China Yuan").tag(2)
                    Text("Mexican Peso").tag(3)
                    Text("South Korean won").tag(4)
                    Text("US Dollar").tag(1)
                }
                
                if secondMoneyTypeInt == 1 {
                    Text("$")
                }
                else if secondMoneyTypeInt == 2 {
                    Text("¥")
                }
                else if firstMoneyTypeInt == 3 {
                    Text("₱")
                }
                else if firstMoneyTypeInt == 4 {
                    Text("₩")
                }
                Text(String(moneyConverted))
            }
            
            Button("convert") {
                moneyThen = Double(us) ?? 0
                if firstMoneyTypeInt == 1 {
                    // USA
                    if secondMoneyTypeInt == 2 {
                        // China
                        moneyMath = moneyThen*722.53/100
                    }
                    else if secondMoneyTypeInt == 1 {
                        // USA
                        moneyMath = moneyThen
                    }
                    else if secondMoneyTypeInt == 3 {
                        // Mexico
                        moneyMath = moneyThen*16.55
                    }
                    else if secondMoneyTypeInt == 4 {
                        // South Korea
                        moneyMath = moneyThen*1343.49
                    }
                }
                else if firstMoneyTypeInt == 2 {
                    // China
                    if secondMoneyTypeInt == 2 {
                        // China
                        moneyMath = moneyThen
                    }
                    else if secondMoneyTypeInt == 1 {
                        // USA
                        moneyMath = moneyThen/722.53*100
                    }
                    else if secondMoneyTypeInt == 3 {
                        // Mexico
                        moneyMath = moneyThen/16.55
                    }
                    else if secondMoneyTypeInt == 4 {
                        // South Korea
                        moneyMath = moneyThen*186.00
                    }
                }
                else if firstMoneyTypeInt == 3 {
                    // Mexico
                    if secondMoneyTypeInt == 2 {
                        // China
                        moneyMath = moneyThen*0.44
                    }
                    else if secondMoneyTypeInt == 1 {
                        // USA
                        moneyMath = moneyThen*0.060
                    }
                    else if secondMoneyTypeInt == 3 {
                        // Mexico
                        moneyMath = moneyThen
                    }
                    else if secondMoneyTypeInt == 4 {
                        // South Korea
                        moneyMath = moneyThen*81.15
                    }
                }
                
                else if firstMoneyTypeInt == 4 {
                    // South Korea
                    if secondMoneyTypeInt == 2 {
                        // China
                        moneyMath = moneyThen*0.0054
                    }
                    else if secondMoneyTypeInt == 1 {
                        // USA
                        moneyMath = moneyThen*0.00074
                    }
                    else if secondMoneyTypeInt == 3 {
                        // Mexico
                        moneyMath = moneyThen*0.012
                    }
                    else if secondMoneyTypeInt == 4 {
                        // South Korea
                        moneyMath = moneyThen
                    }
                }
            moneyConverted = Double(round(100 * (moneyMath)) / 100)
            }
        }
    }
}

#Preview {
    CurrencyConverter()
}
