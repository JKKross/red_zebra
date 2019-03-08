//
//  UserSettings.swift
//  Red Zebra
//
//  Created by Jan Kříž on 04/02/2019.
//  Copyright © 2019 Jan Kříž. All rights reserved.
//

import UIKit

struct UserSettings {
    
    static var font = UIFont(name: fonts[prefferedFontNumber], size: CGFloat(fontSize))
    
    
    static var fonts               = [
                                        "American Typewriter",
                                        "Arial",
                                        "Chalkboard SE",
                                        "Courier New",
                                        "Gill Sans",
                                        "Helvetica Neue",
                                        "Menlo",
                                        "Papyrus",
                                        "Times New Roman"
                                    ]
    
    
    static var fontSize: Float     = 17
    static var prefferedFontNumber = 6
    
    static let defaults     = UserDefaults.standard
    
    
    static func saveSettings() {
        defaults.set(prefferedFontNumber, forKey: Keys.fontFamily)
        defaults.set(fontSize, forKey: Keys.fontSize)
    }
    
    
    static func loadSettings() {
        
        fontSize            = defaults.float(forKey: Keys.fontSize)
        prefferedFontNumber = defaults.integer(forKey: Keys.fontFamily)
        
        //  The saveSettings() method is not called when someone starts the app for the very first time,
        //  which result in:
        //
        //    darkMode     = false
        //    fontToChoose = 0
        //    fontSize     = 0.0
        //
        //  Altough "fontToChoose = 0" is desired ("Menlo" is the default font), the other two are not.
        //
        //  That's why there is this if statement:
        if fontSize < 10 {
            prefferedFontNumber = 6
            fontSize            = 17
            
            //  SettingsViewController also uses some of those values to set it's default values,
            //  that's why we need to save:
            self.saveSettings()
        }
        
        font = UIFont(name: fonts[prefferedFontNumber], size: CGFloat(fontSize))
    }
    
    
    
    fileprivate struct Keys {
        static let fontFamily      = "Font"
        static let fontSize        = "FontSize"
    }
}
