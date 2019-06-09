//
//  DocumentExtension.swift
//  Red Zebra
//
//  Created by Jan Kříž on 24/05/2019.
//  Copyright © 2019 Jan Kříž. All rights reserved.
//

import UIKit

extension Document {
    
    func isHTML() -> Bool {
        
        let fileExtension = self.fileURL.pathExtension
        
        if fileExtension == "html" || fileExtension == "htm" {
            return true
        }
        
        return false
    }


    func isMarkdown() -> Bool {
        
        let fileExtension = self.fileURL.pathExtension
        
        if fileExtension == "md" || fileExtension == "markdown" {
            return true
        }
        
        return false
    }
    
}
