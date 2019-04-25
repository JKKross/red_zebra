//
//  AboutViewController.swift
//  Red Zebra
//
//  Created by Jan Kříž on 24/02/2019.
//  Copyright © 2019 Jan Kříž. All rights reserved.
//

import UIKit

class AboutViewController: CustomBaseViewController {

    
    @IBOutlet var versionNumberLabel: UILabel!
    @IBOutlet var copyright: UILabel!
    @IBOutlet var settingsIconByLabel: UILabel!
    @IBOutlet var aboutTheAppLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        versionNumberLabel.text    = "version 0.7"
        aboutTheAppLabel.textColor = .white
    }

    
    @IBAction func backButtonTapped(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    
}
