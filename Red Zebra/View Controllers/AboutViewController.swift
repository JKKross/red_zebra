//
//  AboutViewController.swift
//  Red Zebra
//
//  Created by Jan Kříž on 24/02/2019.
//  Copyright © 2019 Jan Kříž. All rights reserved.
//

import UIKit

class AboutViewController: CustomBaseViewController {
    
    
    @IBOutlet var aboutTheAppLabel: UITextView!
    
    let aboutTheAppText = #"""
    Red Zebra is a simple text editor inspired by iOS app "Textor" & GNU's terminal text editor "NANO". Red Zebra is open-source software and you can find the source code here.

    I highly appreciate any feedback and/or App Store review.

    As stated previously, this app offers only basic text editing functionality in a familiar iOS Files-like user interface. If you're looking for something more "pro" & you are familiar with Vi-like editors, I'd highly recommend another open-source app - iVim.

    Red Zebra © 2019 Jan Kříž, version 0.7
    """#
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateAboutTheAppTextView()
    }

    
    @IBAction func backButtonTapped(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    
    func updateAboutTheAppTextView() {
        aboutTheAppLabel.textColor = .white
        aboutTheAppLabel.text      = aboutTheAppText
    }
    
    
}
