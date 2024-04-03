//
//  CalcOptions.swift
//  Computation
//
//  Created by Wesley Chastain on 3/18/24.
//

import SwiftUI

struct CalcOptions: View {
    var body: some View {
        NavigationView {
            List {
                Section("Basic Number Calculators") {
                    ForEach(DataModel.data, id: \.id) { object in
                        NavigationLink(object.catigory, destination: DetailView(data: object))
                        
                    }
                }
                
                Section("Equation Calculators") {
                    ForEach(DataModel2.data, id: \.id) { object in
                        NavigationLink(object.catigory, destination: DetailView(data: object))
                        
                    }
                }
                
                Section("Currency Calculators & Converters") {
                    ForEach(DataModel3.data, id: \.id) { object in
                        NavigationLink(object.catigory, destination: DetailView(data: object))
                        
                    }
                }

            }
            
                        
            .navigationTitle("Calculators")
            .navigationBarItems(leading: NavigationLink(destination: Text("home"), label: {
                Image(systemName: "house")
            }),trailing: NavigationLink(destination: Text("settings"), label: {
                Image(systemName: "gear")
            }))
            
            }
        }
    }


#Preview {
    CalcOptions()
}
