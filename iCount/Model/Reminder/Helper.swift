//
//  Helper.swift
//  iCount
//
//  Created by Ionut Ciovica on 28/10/2021.
//

import Foundation

struct Helper {
    static func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]

        return documentsDirectory
    }
}
