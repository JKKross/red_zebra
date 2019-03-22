//
//  SettingsViewController.swift
//  Red Zebra
//
//  Created by Jan Kříž on 23/02/2019.
//  Copyright © 2019 Jan Kříž. All rights reserved.
//

import UIKit

class SettingsViewController: CustomBaseViewController {

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    

    @IBAction func backButtonTapped(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    

    
    
    @IBAction func fontsButtonTapped(_ sender: UIButton) {
        presentVC(named: "FontChooserViewController")
    }
    
    @IBAction func aboutButtonTapped(_ sender: UIButton) {
        presentVC(named: "AboutViewController")
    }
    
    @IBAction func licenseButtonTapped(_ sender: UIButton) {
        presentVC(named: "LicenseViewController")
    }
    
    
    
    fileprivate func presentVC(named VC: String) {
        
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let aboutVC = storyBoard.instantiateViewController(withIdentifier: VC)
        
        present(aboutVC, animated: true, completion: nil)
    }
    
    
}
