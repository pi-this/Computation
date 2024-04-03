//
//  DetailView.swift
//  weather thing
//
//  Created by Wesley Chastain on 3/6/24.
//

import SwiftUI

struct DetailView: View {
    
    var data: HomeOptionsData
    @State var see = false
    
    @State var isPresenting = false
    
    

    
    var body: some View {
        VStack {
            if (data.catigory == "Defult Calculator") {
                ContentView()
            }
            
            else if (data.catigory == "Tip Calculator") {
                TipCalc()
            }
            
            else if (data.catigory == "Black Automatic") {
                AutomaticCalc()
            }
            
            else if (data.catigory == "Basic Black") {
                BasicBlackCalc()
            }
            
            else if (data.catigory == "Currency Converter") {
                CurrencyConverter()
            }
            
            else if (data.catigory == "Pi Formlias") {
                PiCalc()
            }
        }
            .padding()
        }
        
    }

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(data: DataModel.data[0])
    }
}
