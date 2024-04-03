//
//  TotalText.swift
//  Walculator
//
//  Created by Wesley Chastain on 3/12/24.
//

import SwiftUI

struct TotalTextBlack: View {
    var value: String = "0"
    var body: some View {
        Text(value)
                .font(.system(size: 100))
                .fontWeight(.bold)
                .padding()
                .foregroundColor(.white)
                .lineLimit(1)

    }
}

#Preview {
    TotalTextBlack()
        .background(.black)
}
