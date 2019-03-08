//
//  AboutViewController.swift
//  Red Zebra
//
//  Created by Jan Kříž on 24/02/2019.
//  Copyright © 2019 Jan Kříž. All rights reserved.
//

import UIKit

class AboutViewController: UIViewController {

    @IBOutlet var backButton: UIBarButtonItem!
    @IBOutlet var versionNumberLabel: UILabel!
    @IBOutlet var copyright: UILabel!
    @IBOutlet var aboutTheAppLabel: UILabel!
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        backButton.tintColor = .red
        versionNumberLabel.text = "version 0.1 (alpha)"
    }

    
    @IBAction func backButtonTapped(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
}
