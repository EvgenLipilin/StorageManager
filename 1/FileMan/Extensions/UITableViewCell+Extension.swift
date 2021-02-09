//
//  UITableViewCell+Extension.swift
//  fileMan
//
//  Created by Евгений on 08.02.2021.
//

import UIKit

extension UITableViewCell {
    
    static func getObjectCell(for objectType: ObjectType, withTitle title: String) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        
        var content = cell.defaultContentConfiguration()
        
        let imageName = objectType == .directory
            ? ImageNames.directory.rawValue
            : ImageNames.file.rawValue
        
        content.image = UIImage(named: imageName)
        content.text = title
        
        cell.contentConfiguration = content
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
}
