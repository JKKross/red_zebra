//
//  FontChooserViewController.swift
//  Red Zebra
//
//  Created by Jan Kříž on 02/03/2019.
//  Copyright © 2019 Jan Kříž. All rights reserved.
//

import UIKit

class FontChooserViewController: CustomBaseViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    @IBOutlet var fontSizeLabel: UILabel!
    @IBOutlet var fontPicker: UIPickerView!
    @IBOutlet var fontSizeStepper: UIStepper!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.fontPicker.dataSource = self
        self.fontPicker.delegate   = self
        
        self.fontPicker.selectRow(UserSettings.sharedInstance.prefferedFontIndex, inComponent: 0, animated: true)
        
        UserSettings.sharedInstance.loadSettings()
        
        fontSizeLabel.text    = String(Int(UserSettings.sharedInstance.fontSize))
        fontSizeStepper.value = Double(UserSettings.sharedInstance.fontSize)
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
    
    

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return UserSettings.sharedInstance.fonts.count
    }
    
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        
        let outputValue = UserSettings.sharedInstance.fonts[row]
        return NSAttributedString(string: outputValue, attributes: [NSAttributedString.Key.foregroundColor: UIColor.white] )
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        UserSettings.sharedInstance.prefferedFontIndex = row
        UserSettings.sharedInstance.saveSettings()
    }
    
    
}
