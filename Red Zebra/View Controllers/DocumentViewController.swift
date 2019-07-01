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
    @IBOutlet var previewButtonLabel: UIBarButtonItem!
    @IBOutlet var wordCountButtonLabel: UIBarButtonItem!
    
    var document: Document?
    
    private var fileLoadedSuccesfully = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // adjust the text view so that it is not hidden behind keyboard
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(self.adjustForKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(self.adjustForKeyboard), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(self.saveTheDocument), name: UIApplication.willResignActiveNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(self.saveTheDocument), name: UIApplication.willTerminateNotification, object: nil)
        
        textView.delegate = self
        
        undoButtonLabel.isEnabled = false
        redoButtonLabel.isEnabled = false
        doneButtonLabel.isEnabled = false
        
        titleLabel.accessibilityLabel           = "\(document!.fileURL.lastPathComponent)"
        textView.accessibilityLabel             = "Enter your text here"
        undoButtonLabel.accessibilityLabel      = "Undo"
        redoButtonLabel.accessibilityLabel      = "Redo"
        doneButtonLabel.accessibilityLabel      = "Hide keyboard"
        wordCountButtonLabel.accessibilityLabel = "Word Count"
        
        if self.document!.isHTML() {
            previewButtonLabel.title              = "Preview"
            previewButtonLabel.accessibilityLabel = "Preview \(document!.fileURL.lastPathComponent)"
            previewButtonLabel.isEnabled          = true
        } else {
            previewButtonLabel.title     = ""
            previewButtonLabel.isEnabled = false
        }
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
                self.textView.text         = self.document!.text
                self.fileLoadedSuccesfully = true
                
            } else {
                
                self.fileLoadedSuccesfully = false
                self.titleLabel.title      = ""
                self.textView.text         = ""
                self.textView.isEditable   = false
                
                self.showErrorPopUp(message: "Failed to load file \(self.document?.fileURL.lastPathComponent ?? "UNABLE_TO_FIND_FILE_NAME") properly.\nPlease close the file & try again.")
            }
        })
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.saveTheDocument()
    }
    
    
    @IBAction func dismissDocumentViewController() {
        self.dismiss(animated: true)
    }
    
    
    @IBAction func undoTapped(_ sender: UIBarButtonItem) {
        
        textView.undoManager?.undo()
        let canUndo: Bool = textView.undoManager?.canUndo ?? false
        
        if canUndo {
            undoButtonLabel.isEnabled = true
        } else {
            undoButtonLabel.isEnabled = false
        }
    }
    
    
    @IBAction func redoTapped(_ sender: UIBarButtonItem) {
        
        textView.undoManager?.redo()
        let canRedo: Bool = textView.undoManager?.canRedo ?? false
        
        if canRedo {
            redoButtonLabel.isEnabled = true
        } else {
            redoButtonLabel.isEnabled = false
        }
    }
    
    
    @IBAction func doneButton(_ sender: UIBarButtonItem) {
        textView.resignFirstResponder()
    }
    
    
    
    @IBAction func previewButton(_ sender: UIBarButtonItem) {
        
        if self.document!.isHTML() {
            
            let webBrowser = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "WebBrowserViewController") as! WebBrowserViewController
            
            webBrowser.webContent = WebContent(data: self.textView.text, url: self.document?.fileURL)
            
            self.present(webBrowser, animated: true)
            
        }
        
    }
    
    
    @IBAction func wordCountButton(_ sender: UIBarButtonItem) {
        
        let wc = WordCount(text: self.textView.text)
        
        var title = "📖 Word Count 📖"
        let message = """
        
        Characters: \(wc.characters.asFormattedString()),
        Bytes: \(wc.bytes.asFormattedString()),
        Words: \(wc.words.asFormattedString()),
        Lines: \(wc.lines.asFormattedString()).
        
        """
        
        if wc.itsTweetable {
            title = "🐥 It's tweetable! 🐥"
        }
        
        self.showAlertPopUp(title: title, message: message)
    }
    
    
    
    func textViewDidChange(_ textView: UITextView) {
        
        let canUndo: Bool = textView.undoManager?.canUndo ?? false
        let canRedo: Bool = textView.undoManager?.canRedo ?? false
        
        if canUndo {
            undoButtonLabel.isEnabled = true
        } else {
            undoButtonLabel.isEnabled = false
        }
        
        if canRedo {
            redoButtonLabel.isEnabled = true
        } else {
            redoButtonLabel.isEnabled = false
        }
        
    }
    
    
}



extension DocumentViewController {
    
    
    @objc private func saveTheDocument() {
        
        guard self.fileLoadedSuccesfully else { return }
        guard self.document?.text != self.textView.text else { return }
        
        document?.text = textView.text
        document?.updateChangeCount(.done)
        
        self.document?.close(completionHandler: nil)
    }
    
    
    @objc func adjustForKeyboard(notification: Notification) {
        // scrolls the textView so it doesn't become "invisible" behind the keyboard
        let userInfo = notification.userInfo!
        
        let keyboardScreenEndFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let keyboardViewEndFrame = view.convert(keyboardScreenEndFrame, from: view.window)
        
        if notification.name == UIResponder.keyboardWillHideNotification {
            
            textView.contentInset     = UIEdgeInsets.zero
            doneButtonLabel.isEnabled = false
            
        } else {
            
            textView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardViewEndFrame.height, right: 0)
            doneButtonLabel.isEnabled = true
        }
        
        textView.scrollIndicatorInsets = textView.contentInset
        
        let selectedRange = textView.selectedRange
        textView.scrollRangeToVisible(selectedRange)
    }
    
}
