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
        
        fontSizeLabel.text    = String(Int(UserSettings.sharedInstance.preferredFontSize))
        fontSizeStepper.value = Double(UserSettings.sharedInstance.preferredFontSize)
        fontChooserSegmentedControl.selectedSegmentIndex = UserSettings.sharedInstance.preferredFontIndex
        
        updateExampleText()
        
        fontSizeLabel.accessibilityLabel       = "Font size is \(fontSizeLabel.text!)"
        fontExampleTextView.accessibilityLabel = "Font preview"
    }
    
    
    @IBAction func backButtonTapped(_ sender: UIBarButtonItem) {
        UserSettings.sharedInstance.saveSettings()
        dismiss(animated: true)
    }
    
    
    
    @IBAction func fontSizePickerTapped(_ sender: UIStepper) {
        
        UserSettings.sharedInstance.preferredFontSize = Float(fontSizeStepper.value)
        fontSizeLabel.text = String(Int(UserSettings.sharedInstance.preferredFontSize))
        UserSettings.sharedInstance.saveSettings()
        updateExampleText()
    }
    
    
    @IBAction func fontSwitcher(_ sender: UISegmentedControl) {
        
        if sender.selectedSegmentIndex == 0 {
            // "Menlo" selected
            UserSettings.sharedInstance.preferredFontIndex = 0
        } else if sender.selectedSegmentIndex == 1 {
            // "System Font" selected
            UserSettings.sharedInstance.preferredFontIndex = 1
        }
        
        UserSettings.sharedInstance.saveSettings()
        updateExampleText()
    }
    
    
    private func updateExampleText() {
        
        var UIFontForTextView = "UIFont"
        
        switch UserSettings.sharedInstance.preferredFontIndex {
        case 0:
            // "Menlo"
            UIFontForTextView += "(name: \"Menlo\", size: \(UserSettings.sharedInstance.preferredFontSize))"
        default:
            // system font
            UIFontForTextView += ".systemFont(ofSize: \(CGFloat(UserSettings.sharedInstance.preferredFontSize)))"
        }
        
        UserSettings.sharedInstance.loadSettings()
        fontExampleTextView.font = UserSettings.sharedInstance.font
        
        fontExampleTextView.text = """
        // try changing your preferred font or it's size and see how it looks! 😎
        
        import UIKit
        
        struct fontExample {
        
            var myFont = \(UIFontForTextView)
        
            let exampleText = "Hello, world!"
        
        }
        
        """
        
    }
    
    
}
