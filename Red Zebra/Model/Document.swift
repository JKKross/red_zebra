//
//  Document.swift
//  Red Zebra
//
//  Created by Jan Kříž on 12/02/2019.
//  Copyright © 2019 Jan Kříž. All rights reserved.
//

import UIKit


enum DocumentHandlingError: Error {
    case couldNotLoad
}


class Document: UIDocument {
    
    var text: String = ""
    
    override init(fileURL url: URL) {
        super.init(fileURL: url)
    }
    
    
    init(fileName: String) {
        
        let tempDir = FileManager.default.temporaryDirectory
        let url     = tempDir.appendingPathComponent(fileName)
        
        super.init(fileURL: url)
    }

    
    override func contents(forType typeName: String) throws -> Any {
        
        return Data(text.utf8)
    }
    
    
    override func load(fromContents contents: Any, ofType typeName: String?) throws {
        
        guard let contents = contents as? Data else {
            throw DocumentHandlingError.couldNotLoad
        }
        
        text = String(decoding: contents, as: UTF8.self)
    }
    
     
}

