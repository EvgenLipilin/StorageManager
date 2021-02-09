//
//  DirectObj.swift
//  fileMan
//
//  Created by Евгений on 08.02.2021.
//

import Foundation

struct DirectoryObject {
    let name: String
    let url: URL
    
    var isDirectory: Bool {
        url.hasDirectoryPath
    }
}
