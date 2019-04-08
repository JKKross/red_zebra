//
//  UserSettings.swift
//  Red Zebra
//
//  Created by Jan Kříž on 04/02/2019.
//  Copyright © 2019 Jan Kříž. All rights reserved.
//

import UIKit

class UserSettings {
    
    
    private init() {}
    static let sharedInstance = UserSettings()
    
    let defaults = UserDefaults.standard
    
    
    var font  = UIFont(name: "Menlo", size: 17)
    
    var fonts = ["Menlo", "Helvetica"]
    
    
    var fontSize: Float    = 17
    var prefferedFontIndex = 0
    
    
    func saveSettings() {
        defaults.set(prefferedFontIndex, forKey: Keys.fontFamily)
        defaults.set(fontSize, forKey: Keys.fontSize)
    }
    
    
    func loadSettings() {
        
        fontSize            = defaults.float(forKey: Keys.fontSize)
        prefferedFontIndex  = defaults.integer(forKey: Keys.fontFamily)
        
        //  The saveSettings() method is not called when someone starts the app for the very first time,
        //  which results in:
        //
        //    prefferedFontIndex = 0
        //    fontSize           = 0.0
        //
        //  Altough prefferedFontIndex = 0 is what we want ("Menlo" is default font of choice),
        //  font size = 0.0 is not.
        //
        //  That's why there is this if statement:
        if fontSize < 10 {
            fontSize            = 17
            
            //  FontChooserViewController also uses some of those values to set it's default values properly,
            //  that's why we need to save here:
            self.saveSettings()
        }
        
        font = UIFont(name: fonts[prefferedFontIndex], size: CGFloat(fontSize))
    }
    
    
    
    private struct Keys {
        static let fontFamily      = "Font"
        static let fontSize        = "FontSize"
    }
    
}