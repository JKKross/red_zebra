//
//  WebBrowserViewController.swift
//  Red Zebra
//
//  Created by Jan Kříž on 24/05/2019.
//  Copyright © 2019 Jan Kříž. All rights reserved.
//

import UIKit
import WebKit

class WebBrowserViewController: CustomBaseViewController, WKNavigationDelegate {

    @IBOutlet var webView: WKWebView!
    @IBOutlet var navBarTitleLabel: UINavigationItem!
    @IBOutlet var backButtonLabel: UIBarButtonItem!
    @IBOutlet var forwardButtonLabel: UIBarButtonItem!
    
    var webContent: WebContent?
    
    
    override func viewDidLoad() {
        
        webView.navigationDelegate = self
        
        let data = webContent?.data ?? ""
        webView.loadHTMLString(data, baseURL: webContent?.url)
        
        if let fileName = webContent?.url?.lastPathComponent {
            navBarTitleLabel.title = fileName
        } else {
            navBarTitleLabel.title = ""
        }
        
        backButtonLabel.isEnabled    = false
        forwardButtonLabel.isEnabled = false
        
        super.viewDidLoad()
    }
    
    
    
    @IBAction func closeButton(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true)
    }
    
    
    
    @IBAction func backButton(_ sender: UIBarButtonItem) {
        if webView.canGoBack {
            webView.goBack()
        }
    }
    
    
    @IBAction func forwardButton(_ sender: UIBarButtonItem) {
        if webView.canGoForward {
            webView.goForward()
        }
    }
    
    
    
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        
        if webView.canGoBack {
            backButtonLabel.isEnabled = true
        } else {
            backButtonLabel.isEnabled = false
        }
        
        if webView.canGoForward {
            forwardButtonLabel.isEnabled = true
        } else {
            forwardButtonLabel.isEnabled = false
        }
    }
    
    
}
