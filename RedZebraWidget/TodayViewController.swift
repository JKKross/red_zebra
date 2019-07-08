//
//  TodayViewController.swift
//  RedZebraWidget
//
//  Created by Jan Kříž on 08/07/2019.
//  Copyright © 2019 Jan Kříž. All rights reserved.
//

import UIKit
import NotificationCenter

class TodayViewController: UIViewController, NCWidgetProviding {
    
    @IBOutlet var inputLabel: UILabel!
    @IBOutlet var buttons: [UIButton]!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupButtonsUI()
        
//        UIPasteboard.general.string = ""
        UIPasteboard.general.string = "Hello, world"
        
        if let clipboardText = UIPasteboard.general.string {
            
            if clipboardText.count > 0 {
                
                self.inputLabel.text = clipboardText
            } else {
                
                self.inputLabel.text = "There's nothing in your clipboard"
                
                buttons[0].isEnabled = false
                buttons[1].isEnabled = false
            }
        } else {
            
            self.inputLabel.text = "There's nothing in your clipboard"
        }
        
    }
    
    
    private func setupButtonsUI() {
        
        for i in 0..<buttons.count {
            
            buttons[i].tintColor = .white
            buttons[i].backgroundColor = .red
            buttons[i].layer.cornerRadius = 10
            buttons[i].isEnabled = true
        }
    }
    
    
    @IBAction func zalgoifyTapped(_ sender: UIButton) {
    }
    
    
    @IBAction func wordCountTapped(_ sender: UIButton) {
    }
    
}
