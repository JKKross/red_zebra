//
//  CustomBaseViewController.swift
//  Red Zebra
//
//  Created by Jan Kříž on 08/03/2019.
//  Copyright © 2019 Jan Kříž. All rights reserved.
//

import UIKit

class CustomBaseViewController: UIViewController {

    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.tintColor = .red
    }
    

}
