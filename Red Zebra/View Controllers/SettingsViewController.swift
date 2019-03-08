//
//  SettingsViewController.swift
//  Red Zebra
//
//  Created by Jan Kříž on 23/02/2019.
//  Copyright © 2019 Jan Kříž. All rights reserved.
//

import UIKit

class SettingsViewController: CustomBaseViewController {

    
    @IBOutlet var textSizeLabel: UILabel!
    @IBOutlet var textSizeStepper: UIStepper!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        
        UserSettings.saveSettings()
    }
    
    
    @IBAction func chooseFontButtonTapped(_ sender: UIButton) {
        presentVC(named: "FontChooserViewController")
    }
    
    @IBAction func aboutButtonTapped(_ sender: UIButton) {
        presentVC(named: "AboutViewController")
    }
    
    @IBAction func licenseButtonTapped(_ sender: UIButton) {
        presentVC(named: "LicenseViewController")
    }
    
    @IBAction func privacyPolicyButtonTapped(_ sender: UIButton) {
        presentVC(named: "PrivacyPolicyViewController")
    }
    
    
    fileprivate func presentVC(named VC: String) {
        
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let aboutVC = storyBoard.instantiateViewController(withIdentifier: VC)
        
        present(aboutVC, animated: true, completion: nil)
    }
    
    
}
