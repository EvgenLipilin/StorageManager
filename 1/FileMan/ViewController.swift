//
//  ViewController.swift
//  fileMan
//
//  Created by Евгений on 04.02.2021.
//

import UIKit
import Foundation

class ViewController: UIViewController {
    
     let file: File
     let fileManagerService: FileManagerService

    override func viewDidLoad() {
        super.viewDidLoad()
        print(NSHomeDirectory())
    }
    

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return NSHomeDirectory().count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text =  "Жопка \(fileManager.listFiles(in: .Documents))"
        return cell
    }
}

 
