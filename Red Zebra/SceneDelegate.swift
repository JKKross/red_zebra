//
//  SceneDelegate.swift
//  Red Zebra
//
//  Created by Jan Kříž on 28/09/2019.
//  Copyright © 2019 Jan Kříž. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        if let userActivity = connectionOptions.userActivities.first ?? session.stateRestorationActivity {
            // TODO: State restoration
        }
    }
    
    
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        
        guard !URLContexts.isEmpty else { return }
        
        for urlContext in URLContexts {
            // For some reason, even if I select multiple documents in Files app,
            // tap "share" and pick "open in Red Zebra", URLContexts.count returns 1.
            // So this for loop seems unnecessary, right?
            // However, if I try to access the URLContexts set via some other means -
            // for example by .first - this code does nothing...
            //
            // So this is weird, but it somehow works...
            //
            // TODO: Figure out & fix...?
            guard urlContext.url.isFileURL else { return }
            
            guard let documentBrowserViewController = window?.rootViewController as? DocumentBrowserViewController else { return }
            
            documentBrowserViewController.revealDocument(at: urlContext.url, importIfNeeded: true) { (revealedDocumentURL, error) in
                if let error = error {
                    documentBrowserViewController.showErrorPopUp(message: "Failed to reveal the document at URL \(urlContext.url) with error: '\(error)'")
                    return
                }
                
                documentBrowserViewController.presentDocument(at: revealedDocumentURL!)
            }
        }
    }
    
    
}
