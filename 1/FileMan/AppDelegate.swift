//
//  AppDelegate.swift
//  fileMan
//
//  Created by Евгений on 04.02.2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        do {
            guard let rootDirectory = try Directory.getDirectory() else { return true }
            
            let rootViewController = DirectoryViewController(rootDirectory,
                                                             fileManagerService: FileManagerService())
            let navigationController = UINavigationController(rootViewController: rootViewController)
            
            window = UIWindow(frame: UIScreen.main.bounds)
            window?.rootViewController = navigationController
            window?.makeKeyAndVisible()
            
        } catch {
            print(error.localizedDescription)
        }
        
        return true
    }
}

