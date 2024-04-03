//
//  TotalText.swift
//  Walculator
//
//  Created by Wesley Chastain on 3/12/24.
//

import SwiftUI

struct TotalText: View {
    var value: String = "0"
    var textSize: Int = 50
    var body: some View {
        Text(value)
            .font(.system(size: CGFloat(textSize)))
                .fontWeight(.bold)
                .padding()
                .foregroundColor(.white)
                .lineLimit(1)
                

    }
}

#Preview {
    TotalText()
        .background(.black)
}
