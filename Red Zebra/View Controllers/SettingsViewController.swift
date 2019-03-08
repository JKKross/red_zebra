//
//  SettingsViewController.swift
//  Red Zebra
//
//  Created by Jan Kříž on 23/02/2019.
//  Copyright © 2019 Jan Kříž. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet var backButtonLabel: UIBarButtonItem!
    @IBOutlet var textSizeLabel: UILabel!
    @IBOutlet var textSizeStepper: UIStepper!
    @IBOutlet var chooseFontButton: UIButton!
    @IBOutlet var infoButtonLabel: UIButton!
    
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        backButtonLabel.tintColor  = .red
        textSizeStepper.tintColor  = .red
        infoButtonLabel.tintColor  = .red
        chooseFontButton.tintColor = .red
        
        UserSettings.loadSettings()
        
        let fontSizeValue     = Int(UserSettings.fontSize)
        textSizeLabel.text    = String(fontSizeValue)
        textSizeStepper.value = Double(fontSizeValue)
    }
    

    @IBAction func backButtonTapped(_ sender: UIBarButtonItem) {
        
        UserSettings.saveSettings()
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func stepperTapped(_ sender: UIStepper) {
        
        let fontSizeValue  = Int(textSizeStepper.value)
        textSizeLabel.text = String(fontSizeValue)
        UserSettings.fontSize = Float(fontSizeValue)
    }
    
    
    @IBAction func chooseFontButtonTapped(_ sender: UIButton) {
        
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let fontChooserVC = storyBoard.instantiateViewController(withIdentifier: "FontChooserViewController")
        
        present(fontChooserVC, animated: true, completion: nil)
    }
    
    
    @IBAction func aboutButtonTapped(_ sender: UIButton) {
        
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let aboutVC = storyBoard.instantiateViewController(withIdentifier: "AboutViewController")
        
        present(aboutVC, animated: true, completion: nil)
    }
    
}
