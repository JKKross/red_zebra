//
//  DocumentViewController.swift
//  Red Zebra
//
//  Created by Jan Kříž on 12/02/2019.
//  Copyright © 2019 Jan Kříž. All rights reserved.
//

import UIKit

class DocumentViewController: CustomBaseViewController, UITextViewDelegate {
    
    @IBOutlet var titleLabel: UINavigationItem!
    @IBOutlet var textView: UITextView!
    
    
    var document          : Document?
    var timer             : Timer?
    let autosaveInSeconds : TimeInterval = 5 * 60
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // adjust the text view so that it is not hidden behind keyboard
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        
        // autosaving
        timer = Timer.scheduledTimer(timeInterval: autosaveInSeconds, target: self, selector: #selector(self.autosave), userInfo: nil, repeats: true)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        self.textView.text = ""
        
        UserSettings.loadSettings()
        self.textView.font = UserSettings.font
        
        // Access the document
        document?.open(completionHandler: { (success) in
            if success {
                self.titleLabel.title = self.document?.fileURL.lastPathComponent
                self.textView.text    = self.document?.returnFileContents()
            } else {
                self.textView.text    = ""
                self.showErrorPopUp(text: "Failed to load file \(self.document?.fileURL.lastPathComponent ?? "UNABLE_TO_FIND_FILE_NAME")")
            }
        })
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        
        super.viewWillDisappear(animated)
        self.document?.saveCurrentFile(text: self.textView.text)
    }
    
    
    @IBAction func dismissDocumentViewController() {
        dismiss(animated: true) {
            
            self.document?.saveCurrentFile(text: self.textView.text)
            self.document?.close(completionHandler: nil)
        }
    }
    
    
    @IBAction func doneButton(_ sender: UIBarButtonItem) {
        // hides the keyboard
        textView.resignFirstResponder()
        self.document?.saveCurrentFile(text: self.textView.text)
    }
    
    
    @objc func adjustForKeyboard(notification: Notification) {
        // scrolls the textView so it doesn't become "invisible" behind the keyboard
        let userInfo = notification.userInfo!
        
        let keyboardScreenEndFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let keyboardViewEndFrame = view.convert(keyboardScreenEndFrame, from: view.window)
        
        if notification.name == UIResponder.keyboardWillHideNotification {
            textView.contentInset = UIEdgeInsets.zero
        } else {
            textView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardViewEndFrame.height, right: 0)
        }
        
        textView.scrollIndicatorInsets = textView.contentInset
        
        let selectedRange = textView.selectedRange
        textView.scrollRangeToVisible(selectedRange)
    }
    
    
    @objc func autosave() {
        
        if let _ = self.document?.hasUnsavedChanges {
            self.document!.saveCurrentFile(text: self.textView.text)
        }
    }
    
    
    func showErrorPopUp(text: String) {
        
        let alert = UIAlertController(title: "ERROR", message: text, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in return }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    
}
