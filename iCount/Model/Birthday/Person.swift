//
//  Person.swift
//  iCount
//
//  Created by Ionut Ciovica on 05/11/2021.
//
import UIKit

class Person: NSObject, NSCoding, Codable {
    
    var name: String
    var image: String
    var dob: String
    
    init(name: String, image: String, dob: String) {
        self.name = name
        self.image = image
        self.dob  = dob
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.name = aDecoder.decodeObject(forKey: "name") as! String
        self.image = aDecoder.decodeObject(forKey: "image") as! String
        self.dob = aDecoder.decodeObject(forKey: "dob") as! String
    }

    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: "name")
        aCoder.encode(image, forKey: "image")
        aCoder.encode(dob, forKey: "dob")
    }
}
