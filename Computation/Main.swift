//
//  Main.swift
//  Computation
//
//  Created by Wesley Chastain on 3/19/24.
//

import SwiftUI

struct Main: View {
    var body: some View {
        TabView {
            ContentView()
                .tabItem() {
                    Image(systemName: "number")
                    Text("Defult Calculator")
                }
            CalcOptions()
                .tabItem() {
                    Image(systemName: "option")
                    Text("More Calculators")
                }
        }
    }
}

#Preview {
    Main()
}
