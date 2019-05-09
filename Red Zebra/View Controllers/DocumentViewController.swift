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
    @IBOutlet var undoButtonLabel: UIBarButtonItem!
    @IBOutlet var redoButtonLabel: UIBarButtonItem!
    
    
    var document: Document?
    
    private var timer             : Timer?
    private let autosaveInSeconds : TimeInterval = 5 * 60
    
    private var fileLoadedSuccesfully = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // adjust the text view so that it is not hidden behind keyboard
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)

        // autosaving
        timer = Timer.scheduledTimer(timeInterval: autosaveInSeconds, target: self, selector: #selector(self.autosave), userInfo: nil, repeats: true)

        textView.delegate = self

        undoButtonLabel.tintColor = .gray
        redoButtonLabel.tintColor = .gray
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        self.textView.text = ""
        
        UserSettings.sharedInstance.loadSettings()
        self.textView.font = UserSettings.sharedInstance.font
        
        // Access the document
        document?.open(completionHandler: { (success) in
            if success {
                
                do {
                    let fileContents = try self.document!.returnFileContents()
                    
                    self.titleLabel.title      = self.document?.fileURL.lastPathComponent
                    self.textView.text         = fileContents
                    self.fileLoadedSuccesfully = true
                } catch {
                    
                    self.fileLoadedSuccesfully = false
                    self.titleLabel.title      = ""
                    self.textView.text         = ""
                    self.showErrorPopUp(text: "Failed to load file \(self.document?.fileURL.lastPathComponent ?? "UNABLE_TO_FIND_FILE_NAME")")
                }
                
            }
        })
    }


    override func viewWillDisappear(_ animated: Bool) {
        
        super.viewWillDisappear(animated)
        
        timer = nil
        self.save()
    }
    
    
    @IBAction func dismissDocumentViewController() {
        
        timer = nil
        self.save()
        dismiss(animated: true) { self.document?.close(completionHandler: nil) }
    }
    

    @IBAction func undoTapped(_ sender: UIBarButtonItem) {

        textView.undoManager?.undo()
        let canUndo: Bool = textView.undoManager?.canUndo ?? false

        if canUndo {
            undoButtonLabel.tintColor = .red
        } else {
            undoButtonLabel.tintColor = .gray
        }
    }


    @IBAction func redoTapped(_ sender: UIBarButtonItem) {

        textView.undoManager?.redo()
        let canRedo: Bool = textView.undoManager?.canRedo ?? false

        if canRedo {
            redoButtonLabel.tintColor = .red
        } else {
            redoButtonLabel.tintColor = .gray
        }
    }


    @IBAction func doneButton(_ sender: UIBarButtonItem) {
        // hides the keyboard
        textView.resignFirstResponder()
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


    func textViewDidChange(_ textView: UITextView) {

        let canUndo: Bool = textView.undoManager?.canUndo ?? false
        let canRedo: Bool = textView.undoManager?.canRedo ?? false

        if canUndo {
            undoButtonLabel.tintColor = .red
        } else {
            undoButtonLabel.tintColor = .gray
        }

        if canRedo {
            redoButtonLabel.tintColor = .red
        } else {
            redoButtonLabel.tintColor = .gray
        }
    }
    
    
    private func save() {
        
        guard self.fileLoadedSuccesfully else {
            
            self.showErrorPopUp(text: "File \(self.document?.fileURL.lastPathComponent ?? "UNABLE_TO_FIND_FILE_NAME") did not load properly. Please try closing & opening it again.")
            return
        }
        
        do {
            try self.document!.saveCurrentFile(text: self.textView.text)
        } catch {
            self.showErrorPopUp(text: "Could not save file \(self.document?.fileURL.lastPathComponent ?? "UNABLE_TO_FIND_FILE_NAME")")
        }
    }
    

    @objc private func autosave() {

        if let _ = self.document?.hasUnsavedChanges {
            self.save()
        }
    }
    
    
    private func showErrorPopUp(text: String) {
        
        let alert = UIAlertController(title: "🤔 ERROR 🤷🏽‍♀️", message: text, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in return }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    
}
