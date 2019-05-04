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

    Red Zebra is a simple text editor inspired by iOS app Textor & GNU's terminal text editor NANO. Red Zebra is open-source software and you can find the source code here.

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
        
        let textForRanges = NSString(string: aboutTheAppText)
        let textorRange   = textForRanges.range(of: "Textor")
        let nanoRange     = textForRanges.range(of: "NANO")
        let hereRange     = textForRanges.range(of: "here")
        let iVimRange     = textForRanges.range(of: "iVim")
        
        let functionRange = textForRanges.range(of: "feedback")
        
        let attributedString = NSMutableAttributedString(string: aboutTheAppText)
        attributedString.addAttribute(.link, value: "https://github.com/louisdh/textor", range: textorRange)
        attributedString.addAttribute(.link, value: "https://www.nano-editor.org", range: nanoRange)
        attributedString.addAttribute(.link, value: "https://github.com/JKKross/Red_Zebra", range: hereRange)
        attributedString.addAttribute(.link, value: "https://itunes.apple.com/us/app/ivim/id1266544660?mt=8", range: iVimRange)
        
        
        let font = aboutTheAppLabel.font
        aboutTheAppLabel.attributedText = attributedString
        aboutTheAppLabel.font = font
        aboutTheAppLabel.textColor = .white
    }
    
    
}
