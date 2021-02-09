//
//  Directory.swift
//  fileMan
//
//  Created by Евгений on 08.02.2021.
//

import Foundation

struct Directory {
    let name: String
    let url: URL?
    let objects: [DirectoryObject]
    
    var objectCount: Int {
        objects.count
    }
}

extension Directory {
    
    static func getDirectory(for directoryURL: URL? = nil) throws -> Directory? {
        
        guard let directoryURL = directoryURL ?? FileManagerService().getRootURL() else {
            return nil
        }
        
        guard let directoryContentURLs = FileManagerService().getDirectoryObjectsURLs(in: directoryURL) else {
            return nil
        }
        
        var objects = [DirectoryObject]()
        
        directoryContentURLs.forEach { objectURL in
            let object = DirectoryObject(name: objectURL.lastPathComponent, url: objectURL)
            objects.append(object)
        }
        
        return Directory(name: directoryURL.lastPathComponent, url: directoryURL, objects: objects)
    }
}
