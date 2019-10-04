//
//  UserSettings.swift
//  Red Zebra
//
//  Created by Jan Kříž on 04/02/2019.
//  Copyright © 2019 Jan Kříž. All rights reserved.
//
import UIKit

class UserSettings {
    
    private let defaults = UserDefaults.standard
    
    private init() {}
    static public let sharedInstance = UserSettings()
    
    public var font  = UIFont(name: "Menlo", size: 17)
    
    public var preferredFontSize: Float = 17
    public var preferredFontIndex       = 0
    
    
    public func saveSettings() {
        defaults.set(preferredFontIndex, forKey: Keys.fontFamily)
        defaults.set(preferredFontSize, forKey: Keys.fontSize)
    }
    
    
    public func loadSettings() {
        
        preferredFontSize   = defaults.float(forKey: Keys.fontSize)
        preferredFontIndex  = defaults.integer(forKey: Keys.fontFamily)
        
        //  The saveSettings() method is not called when
        //  someone starts the app for the very first time,
        //  which results in:
        //
        //    prefferedFontIndex = 0
        //    fontSize           = 0.0
        //
        //  Altough prefferedFontIndex = 0 is what we want ("Menlo" is default font of choice),
        //  font size = 0.0 is not.
        //
        //  That's why:
        if preferredFontSize < 5 {
            preferredFontSize = 17
            
            //  FontChooserViewController also uses some of those values
            //  to set it's default values properly,
            //  that's why we need to save here:
            self.saveSettings()
        }
        
        switch preferredFontIndex {
        case 0:
            // "Menlo"
            font = UIFont(name: "Menlo", size: CGFloat(preferredFontSize))
        case 1:
            // system (San Francisco)
            font = UIFont.systemFont(ofSize: CGFloat(preferredFontSize))
        default:
            // this should never happen
            fatalError("ERROR: Invalid font index selected while loading from UserSettingSingleton.")
        }
    }
    
    
    
    private struct Keys {
        static let fontFamily = "Font"
        static let fontSize   = "FontSize"
    }
    
}
