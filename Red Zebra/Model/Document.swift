//
//  Document.swift
//  Red Zebra
//
//  Created by Jan Kříž on 12/02/2019.
//  Copyright © 2019 Jan Kříž. All rights reserved.
//

import UIKit



class Document: UIDocument {
    
    
    override init(fileURL url: URL) {
        
        super.init(fileURL: url)
    }
    
    
    init(fileName: String) {
        
        let tempDir = FileManager.default.temporaryDirectory
        let url = tempDir.appendingPathComponent(fileName)
        
        super.init(fileURL: url)
    }

    
    override func contents(forType typeName: String) throws -> Any {
        // Encode your document with an instance of NSData or NSFileWrapper
        
        return Data()
    }
    
    
    override func load(fromContents contents: Any, ofType typeName: String?) throws {
        // Load your document from contents
    }
    
    
    func returnFileContents() -> String {
        
        do {
            let fileData = try Data(contentsOf: self.fileURL)
            let text = String(decoding: fileData, as: UTF8.self)
            return text
        } catch {
            print("Something went wrong with file loading")
        }

        return ""
    }
    
    
    func saveCurrentFile(text: String) {
        
        let fileData = Data(text.utf8)
        
        do {
            try self.writeContents(fileData, to: self.fileURL, for: .forOverwriting, originalContentsURL: self.fileURL)
        } catch {
            print("\n\nFECK\n\n")
        }
        
        
        
        
//        self.save(to: self.fileURL, for: .forOverwriting, completionHandler: { _ in return })
        
        
        //return Result.success
    }
    
    
}

