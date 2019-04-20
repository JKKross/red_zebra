//
//  DocumentBrowserViewController.swift
//  Red Zebra
//
//  Created by Jan Kříž on 12/02/2019.
//  Copyright © 2019 Jan Kříž. All rights reserved.
//

import UIKit


class DocumentBrowserViewController: UIDocumentBrowserViewController, UIDocumentBrowserViewControllerDelegate {
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        UserSettings.sharedInstance.loadSettings()
        
        let icon = UIImage(named: "settings_icon", in: nil, compatibleWith: nil)
        let item = UIBarButtonItem(image: icon, style: .plain, target: self, action: #selector(presentSettingsView))
        self.additionalLeadingNavigationBarButtonItems = [item]
        
        
        let action = UIDocumentBrowserAction(identifier: "ChangeExtension", localizedTitle: "Change file extension", availability: .menu, handler: { url in self.changeFileExtension(files: url) })
        
        self.customActions = [action]
        
        delegate = self
        
        allowsDocumentCreation     = true
        allowsPickingMultipleItems = false
        
        browserUserInterfaceStyle  = .dark
        view.tintColor             = .red
    }
    
    
    
    func createNamedFile(controller: UIDocumentBrowserViewController, importHandler: @escaping (URL?, UIDocumentBrowserViewController.ImportMode) -> Void) {
        
        /*
         
         this function in a hacky way mixes together the pop-up for naming your file and the file creation,
         normally handled by:
         
         func documentBrowser(_ controller: UIDocumentBrowserViewController, didRequestDocumentCreationWithHandler importHandler: @escaping (URL?, UIDocumentBrowserViewController.ImportMode) -> Void)
         
         Probably should refactor in the future.
         
         */
        
        let alert = UIAlertController(title: "Name your file", message: nil, preferredStyle: .alert)
        
        alert.addTextField(configurationHandler: { (textField) in
            textField.placeholder = "e.g.: myFile.txt"
        })
        
        alert.addAction(UIAlertAction(title: NSLocalizedString("Cancel", comment: "Default action"), style: .cancel, handler: { _ in
            
            importHandler(nil, .none)
            return
        }))
        
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
            
            // what happens when user presses "OK"
            
            guard let name = alert.textFields![0].text else {
                importHandler(nil, .none)
                return
            }
            
            guard name.first?.isLetter == true else {
                self.showErrorPopUp(text: #"You have to begin your file name with a letter ("a-z" or "A-Z")"#)
                importHandler(nil, .none)
                return
            }
            
            guard self.doesHaveAnExtension(fileName: name) == true else {
                self.showErrorPopUp(text: #"You have to give your file an extension (e.g.: ".txt", ".swift" etc.)"#)
                importHandler(nil, .none)
                return
            }
            
            guard self.fileNameIsOkToUse(fileName: name) == true else {
                // Cancel document creation
                self.showErrorPopUp(text: #"You can only use characters "a-z", "A-Z", "0-9", "_" & "." followed by an extension name (e.g.: "Hello_World_v2.swift")"#)
                importHandler(nil, .none)
                return
            }
            
            let newDocument    = Document(fileName: name)
            let newDocumentURL = newDocument.fileURL
            
            // Create a new document in a temporary location
            newDocument.save(to: newDocumentURL, for: .forCreating) { (saveSuccess) in
                
                // Make sure the document saved successfully
                guard saveSuccess else {
                    // Cancel document creation
                    self.showErrorPopUp(text: "You have to name your file")
                    importHandler(nil, .none)
                    return
                }
                
                // Close the document.
                newDocument.close(completionHandler: { (closeSuccess) in
                    
                    // Make sure the document closed successfully
                    guard closeSuccess else {
                        // Cancel document creation
                        self.showErrorPopUp(text: "Unable to create new document")
                        importHandler(nil, .none)
                        return
                    }
                    
                    // Pass the document's temporary URL to the import handler.
                    importHandler(newDocumentURL, .move)
                })
            }
            
            return }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    
    
    func documentBrowser(_ controller: UIDocumentBrowserViewController, didRequestDocumentCreationWithHandler importHandler: @escaping (URL?, UIDocumentBrowserViewController.ImportMode) -> Void) {
        
        createNamedFile(controller: controller, importHandler: importHandler)
    }
    
    
    
    func documentBrowser(_ controller: UIDocumentBrowserViewController, didPickDocumentsAt documentURLs: [URL]) {
        
        guard let sourceURL = documentURLs.first else {
            showErrorPopUp(text: "Unable to open file")
            return
        }
        
        // Present the Document View Controller for the first document that was picked.
        presentDocument(at: sourceURL)
    }
    
    
    
    func documentBrowser(_ controller: UIDocumentBrowserViewController, didImportDocumentAt sourceURL: URL, toDestinationURL destinationURL: URL) {
        
        // Present the Document View Controller for the new newly created document
        presentDocument(at: destinationURL)
    }
    
    
    
    func documentBrowser(_ controller: UIDocumentBrowserViewController, failedToImportDocumentAt documentURL: URL, error: Error?) {
        
        showErrorPopUp(text: "Unable to open file")
    }
    
    
    
    func presentDocument(at documentURL: URL) {
        
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let documentViewController = storyBoard.instantiateViewController(withIdentifier: "DocumentViewController") as! DocumentViewController
        documentViewController.document = Document(fileURL: documentURL)
        
        present(documentViewController, animated: true, completion: nil)
    }
    
    
    @objc func presentSettingsView() {
        
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let settingsVC = storyBoard.instantiateViewController(withIdentifier: "SettingsViewController")
        settingsVC.modalPresentationStyle = .formSheet
        
        present(settingsVC, animated: true, completion: nil)
    }
    
    
    func showErrorPopUp(text: String) {
        
        let alert = UIAlertController(title: "ERROR", message: text, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in return }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    
    
    //     WORK IN PROGRESS
    
    func changeFileExtension(files url: [URL]) {
        
        var documentsToChange = url
        
        let alert = UIAlertController(title: "Change the extension:", message: #"e.g.: "txt", "swift", "c", etc."#, preferredStyle: .alert)
        
        alert.addTextField(configurationHandler: { textField in
            textField.placeholder = "txt"
        })
        
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
            
            guard var newExtension = alert.textFields![0].text else { return }
            
            if newExtension.first == "." {
                newExtension.removeFirst()
            }
            
            for i in newExtension {
                guard i.isLetter || i.isNumber else {
                    self.showErrorPopUp(text: "Invalid file extension")
                    return
                }
            }
            
            // the rest of this closure is really hacky, don't touch
            documentsToChange[0].deletePathExtension()
            documentsToChange[0].appendPathExtension(newExtension)
            
            let newDocumentName = documentsToChange[0].lastPathComponent
            
            let newDoc    = Document(fileName: newDocumentName)
            let newDocURL = newDoc.fileURL
            
            
            // Create a new document in a temporary location
            newDoc.save(to: newDocURL, for: .forCreating) { (saveSuccess) in

                newDoc.saveCurrentFile(text: Document(fileURL: url[0]).returnFileContents())
                // Make sure the document saved successfully
                guard saveSuccess else {
                    // Cancel document creation
                    self.showErrorPopUp(text: "Oops! Something went wrong!\nTry again, please.")
                    return
                }

                // Close the document.
                newDoc.close(completionHandler: { (closeSuccess) in

                    // Make sure the document closed successfully
                    guard closeSuccess else {
                        self.showErrorPopUp(text: "Oops! Something went wrong!\nTry again, please.")
                        return
                    }

                    // Pass the document's temporary URL to the import handler.
                    self.importDocument(at: newDocURL, nextToDocumentAt: url[0], mode: .move, completionHandler: { _,_ in

                        // when everything is finished, remove the original file
                        let fileManager = FileManager.default
                        do {
                            try fileManager.removeItem(atPath: url[0].path)
                        } catch {
                            self.showErrorPopUp(text: "Could not remove \(url[0].lastPathComponent).\nPlease remove manualy.")
                        }
                        return })
                    return
                })
                return
            }
            return
        }))
        
        
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { _ in
            return
        }))
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
    
    
    func fileNameIsOkToUse(fileName file: String) -> Bool {
        
        for i in file {
            if i.isLetter == false && i.isNumber == false && i != "." && i != "_" && i != "-" && i != "(" && i != ")" && i != " " {
                return false
            }
        }
        return true
    }
    
    
    func doesHaveAnExtension(fileName: String) -> Bool {
        
        var file = fileName
        
        for _ in file {
            
            let dot = file.removeFirst()
            
            if dot == "." {
                
                for _ in file {
                    
                    let ext = file.removeFirst()
                    if ext == " " {
                        return false
                    }
                }
                return true
            }
        }
        return false
    }
    
    
}

