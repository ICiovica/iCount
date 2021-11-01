//
//  ExchangeData.swift
//  iCount
//
//  Created by Ionut Ciovica on 01/11/2021.
//

import Foundation

struct ExchangeData: Decodable {
    let rates: [String:Double]
}
