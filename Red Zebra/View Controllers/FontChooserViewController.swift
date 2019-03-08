//
//  FontChooserViewController.swift
//  Red Zebra
//
//  Created by Jan Kříž on 02/03/2019.
//  Copyright © 2019 Jan Kříž. All rights reserved.
//

import UIKit

class FontChooserViewController: CustomBaseViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    
    @IBOutlet var fontPicker: UIPickerView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.fontPicker.dataSource = self
        self.fontPicker.delegate   = self
        
        self.fontPicker.selectRow(UserSettings.prefferedFontIndex, inComponent: 0, animated: true)
    }
    

    @IBAction func backButtonTapped(_ sender: UIBarButtonItem) {
        UserSettings.saveSettings()
        dismiss(animated: true, completion: nil)
    }
    

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return UserSettings.fonts.count
    }
    
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        
        let outputValue = UserSettings.fonts[row]
        return NSAttributedString(string: outputValue, attributes: [NSAttributedString.Key.foregroundColor: UIColor.white] )
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        UserSettings.prefferedFontIndex = row
    }
    
    
}
