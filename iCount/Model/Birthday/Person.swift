//
//  Person.swift
//  iCount
//
//  Created by Ionut Ciovica on 05/11/2021.
//
import UIKit

class Person: NSObject, Codable {
    var name: String
    var image: String
    var day: String
    var month: String
    
    init(name: String, image: String, day: String, month: String) {
        self.name = name
        self.image = image
        self.day = day
        self.month = month
    }
}
