//
//  DataModel.swift
//  weather thing
//
//  Created by Wesley Chastain on 3/6/24.
//

import UIKit
import SwiftUI

struct HomeOptionsData: Hashable {
    var id: Int
    var catigory: String
}

class DataModel: NSObject {
    static let data: [HomeOptionsData] = [
        HomeOptionsData(id: 1, catigory: "Defult Calculator"),
        HomeOptionsData(id: 2, catigory: "Basic Black"),
        HomeOptionsData(id: 3, catigory: "Black Automatic")
    ]
}

class DataModel2: NSObject {
    static let data: [HomeOptionsData] = [
        HomeOptionsData(id: 1, catigory: "Pi Formlias")
    ]
}

class DataModel3: NSObject {
    static let data: [HomeOptionsData] = [
        HomeOptionsData(id: 2, catigory: "Tip Calculator"),
        HomeOptionsData(id: 3, catigory: "Currency Converter")
    ]
}
