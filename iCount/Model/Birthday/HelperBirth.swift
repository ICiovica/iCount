//
//  HelperBirth.swift
//  iCount
//
//  Created by Ionut Ciovica on 09/11/2021.
//

import Foundation

struct HelperBirth {
    static func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]

        return documentsDirectory
    }
}
