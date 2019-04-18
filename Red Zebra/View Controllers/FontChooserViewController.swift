//
//  FontChooserViewController.swift
//  Red Zebra
//
//  Created by Jan Kříž on 02/03/2019.
//  Copyright © 2019 Jan Kříž. All rights reserved.
//

import UIKit

class FontChooserViewController: CustomBaseViewController {
    
    @IBOutlet var fontSizeLabel: UILabel!
    @IBOutlet var fontSizeStepper: UIStepper!
    @IBOutlet var fontChooserSegmentedControl: UISegmentedControl!
    @IBOutlet var fontExampleTextView: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UserSettings.sharedInstance.loadSettings()
        
        fontSizeLabel.text    = String(Int(UserSettings.sharedInstance.fontSize))
        fontSizeStepper.value = Double(UserSettings.sharedInstance.fontSize)
        
        updateExampleText()
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        UserSettings.sharedInstance.saveSettings()
    }
    

    @IBAction func backButtonTapped(_ sender: UIBarButtonItem) {
        UserSettings.sharedInstance.saveSettings()
        dismiss(animated: true, completion: nil)
    }
    
    
    
    @IBAction func fontSizePickerTapped(_ sender: UIStepper) {
        
        UserSettings.sharedInstance.fontSize = Float(fontSizeStepper.value)
        fontSizeLabel.text                   = String(Int(UserSettings.sharedInstance.fontSize))
        UserSettings.sharedInstance.saveSettings()
        updateExampleText()
    }
    
  
    @IBAction func fontSwitcher(_ sender: UISegmentedControl) {
        
        if sender.selectedSegmentIndex == 0 {
            // "Menlo" selected
            UserSettings.sharedInstance.prefferedFontIndex = 0
        } else if sender.selectedSegmentIndex == 1 {
            // "Helvetica" selected
            UserSettings.sharedInstance.prefferedFontIndex = 1
        }
        
        UserSettings.sharedInstance.saveSettings()
        updateExampleText()
    }
    
    
    func updateExampleText() {
        
        UserSettings.sharedInstance.loadSettings()
        fontExampleTextView.font = UserSettings.sharedInstance.font
        
        fontExampleTextView.text = """
        // try changing your prefered font or it's size and see how it looks! 😎
        
        struct fontExample {
        
            var myFont: UIFont = UIFont(name: "\(UserSettings.sharedInstance.fonts[UserSettings.sharedInstance.prefferedFontIndex])", size: \(UserSettings.sharedInstance.fontSize))
        
        }
        """
        
    }
    
    
}
