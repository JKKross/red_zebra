//
//  AppDelegate.swift
//  Red Zebra
//
//  Created by Jan Kříž on 12/02/2019.
//  Copyright © 2019 Jan Kříž. All rights reserved.
//
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let fileManager   = FileManager.default
        let homeDirectory = "\(NSHomeDirectory())/Documents"
        
        if fileManager.fileExists(atPath: "\(homeDirectory)/.red_zebra") == false {
            
            let emptyFile = Data.init()
            fileManager.createFile(atPath: "\(homeDirectory)/.red_zebra", contents: emptyFile, attributes: nil)
        }
        
        return true
    }
    
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
}
