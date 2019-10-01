//
//  UIViewControllerExtension.swift
//  Red Zebra
//
//  Created by Jan Kříž on 22/05/2019.
//  Copyright © 2019 Jan Kříž. All rights reserved.
//
import UIKit

extension UIViewController {
    
    func showAlertPopUp(title: String, message: String = "") {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in return }))
        
        self.present(alert, animated: true)
    }
    
    
    
    func showErrorPopUp(message: String) {
        self.showAlertPopUp(title: "🤔 ERROR 🤷🏽‍♀️", message: message)
    }
    
    
}
