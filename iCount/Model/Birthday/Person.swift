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
    var dob: String
    
    init(name: String, image: String, dob: String) {
        self.name = name
        self.image = image
        self.dob  = dob
    }
}
