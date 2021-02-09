//
//  FileManagerService.swift
//  fileMan
//
//  Created by Евгений on 04.02.2021.
//

import Foundation


struct FileManagerService {
    
    private let fileManager = FileManager.default
    
    // MARK: - Public methods
    func getRootURL() -> URL? {
        guard let url = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else {
            return nil
        }
        return url
    }
    
    func getDirectoryObjectsURLs(in directory: URL) -> [URL]? {
        try? fileManager.contentsOfDirectory(
            at: directory,
            includingPropertiesForKeys: nil,
            options: []
        )
    }
    
    func readFile(url: URL) -> String {
        let filePath = url.relativePath
        
        guard let fileContent = fileManager.contents(atPath: filePath),
              let fileContentEncoded = String(bytes: fileContent, encoding: .utf8) else {
            return ""
        }
        return fileContentEncoded
    }
    
    func createDirectory(in directory: URL, withName name: String) {
        let path = directory.appendingPathComponent(name)
        
        do {
            try fileManager.createDirectory(
                at: path,
                withIntermediateDirectories: true,
                attributes: nil
            )
        }
        catch {
            print(error.localizedDescription)
        }
    }
    
    func writeFile(in directory: URL, withName name: String, containing content: String = "Hello world!") {
        let path = directory.path + "/" + name
        
        let rawData: Data? = content.data(using: .utf8)
        fileManager.createFile(atPath: path, contents: rawData, attributes: nil)
    }
    
    func deleteObject(in directory: URL, withName name: String) {
        let path = directory.appendingPathComponent(name)
        
        do {
            try fileManager.removeItem(at: path)
        } catch {
            print(error.localizedDescription)
        }
    }
}
