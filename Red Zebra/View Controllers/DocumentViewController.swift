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

        undoButtonLabel.tintColor = .gray
        redoButtonLabel.tintColor = .gray
        doneButtonLabel.tintColor = .gray
        
        if self.document!.is_HTML_or_markdown() {
            previewButtonLabel.title = "Preview"
        } else {
            previewButtonLabel.title = ""
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
                self.textView.text         = self.document?.text ?? ""
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
    
    
    @IBAction func dismissDocumentViewController() {
        
        guard self.fileLoadedSuccesfully else {
            
            self.dismiss(animated: true)
            return
        }
        
        if document?.text == textView.text {
            
            self.dismiss(animated: true)
            return
            
        } else {
           
            document?.text = textView.text
            document?.updateChangeCount(.done)
        }
        
        
        self.dismiss(animated: true) { self.document?.close(completionHandler: nil) }
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
        textView.resignFirstResponder()
    }
    
    
    
    @IBAction func previewButton(_ sender: UIBarButtonItem) {
        
        if self.document!.is_HTML_or_markdown() == false { return }
        
        let webBrowser = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "WebBrowserViewController") as! WebBrowserViewController
        
        webBrowser.webContent = WebContent(data: self.textView.text, url: self.document?.fileURL)
        
        self.present(webBrowser, animated: true)
        
    }
    
    
    @IBAction func wordCountButton(_ sender: UIBarButtonItem) {
        
        let wc = WordCount(text: self.textView.text)
        
        var title = "📖 Word Count 📖"
        let message = """
        
        Characters: \(wc.characters.asFormattedString())
        Words: \(wc.words.asFormattedString())
        Lines: \(wc.lines.asFormattedString())
        
        Encoding: utf8
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
    
    
}



extension DocumentViewController {
    
    
    @objc private func saveTheDocument() {
        
        guard self.fileLoadedSuccesfully else { return }
        
        if document?.text != textView.text {
            document?.text = textView.text
            document?.updateChangeCount(.done)
        }
        
        self.document?.close(completionHandler: nil)
    }
    
    
    @objc func adjustForKeyboard(notification: Notification) {
        // scrolls the textView so it doesn't become "invisible" behind the keyboard
        let userInfo = notification.userInfo!
        
        let keyboardScreenEndFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let keyboardViewEndFrame = view.convert(keyboardScreenEndFrame, from: view.window)
        
        if notification.name == UIResponder.keyboardWillHideNotification {
            
            textView.contentInset     = UIEdgeInsets.zero
            doneButtonLabel.tintColor = .gray
            
        } else {
            
            textView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardViewEndFrame.height, right: 0)
            doneButtonLabel.tintColor = .red
        }
        
        textView.scrollIndicatorInsets = textView.contentInset
        
        let selectedRange = textView.selectedRange
        textView.scrollRangeToVisible(selectedRange)
    }
    
}
