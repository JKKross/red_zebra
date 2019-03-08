//
//  PrivacyPolicyViewController.swift
//  Red Zebra
//
//  Created by Jan Kříž on 08/03/2019.
//  Copyright © 2019 Jan Kříž. All rights reserved.
//

import UIKit

class PrivacyPolicyViewController: CustomBaseViewController {
    
    
    @IBOutlet var privacyPolicyLabel: UILabel!
    
    
    
    fileprivate let privacyText = """
    My Privacy Policy is simple:
    
    I have no way to access your data.
    This app is completely self contained.
    Everything you do in this app is private, unless you decide to share it with someone yourself.
    """
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UserSettings.loadSettings()

        privacyPolicyLabel.font = UserSettings.font
        privacyPolicyLabel.text = self.privacyText
    }
    
    
    @IBAction func backButtonTapped(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
}
