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
    @IBOutlet var doneButtonLabel: UIBarButtonItem!
    @IBOutlet var linesLabel: UIBarButtonItem!
    
    var document: Document?
    
    private var fileLoadedSuccesfully = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // adjust the text view so that it is not hidden behind keyboard
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)

        textView.delegate = self

        undoButtonLabel.tintColor = .gray
        redoButtonLabel.tintColor = .gray
        doneButtonLabel.tintColor = .gray
        linesLabel.tintColor      = .white
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        self.textView.text = ""
        
        UserSettings.sharedInstance.loadSettings()
        self.textView.font = UserSettings.sharedInstance.font
        
        // Access the document
        document?.open(completionHandler: { (success) in
            if success {
                
                self.titleLabel.title      = self.document?.fileURL.lastPathComponent
                self.textView.text         = self.document?.text ?? ""
                
                let linesTotal             = self.textView.text.countAllLines()
                
                if linesTotal > 10_000 {
                    self.showErrorPopUp(message: "Wow! That's a looong file!\nI'd recommend you split it into multiple files, otherwise, performance will probably be impacted.")
                }
                
                self.linesLabel.title      = "Line: --/\(linesTotal)"
                self.fileLoadedSuccesfully = true
                
            } else {
                
                self.fileLoadedSuccesfully = false
                self.titleLabel.title      = ""
                self.textView.text         = ""
                self.showErrorPopUp(message: "Failed to load file \(self.document?.fileURL.lastPathComponent ?? "UNABLE_TO_FIND_FILE_NAME")")
            }
        })
    }
    
    
    @IBAction func dismissDocumentViewController() {
        
        guard self.fileLoadedSuccesfully else {
            
            self.showErrorPopUp(message: "File \(self.document?.fileURL.lastPathComponent ?? "UNABLE_TO_FIND_FILE_NAME") did not load properly. Please try closing & opening it again.")
            dismiss(animated: true)
            return
        }
        
        if document?.text == textView.text {
            
            dismiss(animated: true)
            return
        } else {
           
            document?.text = textView.text
            document?.updateChangeCount(.done)
        }
        
        
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
            
            textView.contentInset     = UIEdgeInsets.zero
            doneButtonLabel.tintColor = .gray
            self.linesLabel.title     = "Line: --/\(self.textView.text.countAllLines())"
            
        } else {
            
            textView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardViewEndFrame.height, right: 0)
            doneButtonLabel.tintColor = .red
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
    
    
    func textViewDidChangeSelection(_ textView: UITextView) {
        
        let cursorInTextView = Range(textView.selectedRange)!.lowerBound
        
        self.linesLabel.title = "Line: \(self.textView.text.countLinesFromBeginning(upTo: cursorInTextView))/\(self.textView.text.countAllLines())"
    }
    
    
}
