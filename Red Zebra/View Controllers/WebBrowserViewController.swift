//
//  WebBrowserViewController.swift
//  Red Zebra
//
//  Created by Jan Kříž on 24/05/2019.
//  Copyright © 2019 Jan Kříž. All rights reserved.
//

import UIKit
import WebKit

class WebBrowserViewController: CustomBaseViewController {

    @IBOutlet var titleLabel: UINavigationItem!
    @IBOutlet var webView: WKWebView!
    
    var webContent: WebContent?
    
    
    override func viewDidLoad() {
        
        let data = webContent?.data ?? ""
        webView.loadHTMLString(data, baseURL: webContent?.url)
        
        super.viewDidLoad()
    }
    
    
    @IBAction func dismissButton(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true)
    }
    
    
}
