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
    @IBOutlet var menloButton: UIButton!
    @IBOutlet var helveticaButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UserSettings.sharedInstance.loadSettings()
        
        fontSizeLabel.text    = String(Int(UserSettings.sharedInstance.fontSize))
        fontSizeStepper.value = Double(UserSettings.sharedInstance.fontSize)
        
        updateButtonsAppearance()
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
    }
    
    
    @IBAction func menloTapped(_ sender: UIButton) {
        
        UserSettings.sharedInstance.prefferedFontIndex = 0
        updateButtonsAppearance()
        UserSettings.sharedInstance.saveSettings()
    }
    
    
    @IBAction func helveticaTapped(_ sender: UIButton) {
        
        UserSettings.sharedInstance.prefferedFontIndex = 1
        updateButtonsAppearance()
        UserSettings.sharedInstance.saveSettings()
    }
    
    
    func updateButtonsAppearance() {
        
        menloButton.layer.cornerRadius        = 5
        helveticaButton.layer.cornerRadius = 5
        
        if UserSettings.sharedInstance.prefferedFontIndex == 0 {
            menloButton.backgroundColor        = .red
            menloButton.tintColor              = .black
            helveticaButton.backgroundColor = .clear
            helveticaButton.tintColor       = .red
        } else {
            helveticaButton.backgroundColor = .red
            helveticaButton.tintColor       = .black
            menloButton.backgroundColor        = .clear
            menloButton.tintColor              = .red
        }
    }
    
}
