//
//  DocumentExtension.swift
//  Red Zebra
//
//  Created by Jan Kříž on 24/05/2019.
//  Copyright © 2019 Jan Kříž. All rights reserved.
//

import UIKit

extension Document {
    
    func is_HTML_or_markdown() -> Bool {
        
        let fileExtension = self.fileURL.pathExtension
        
        if fileExtension == "html" || fileExtension == "htm" || fileExtension == "md" {
            return true
        }
        
        return false
    }
    
}
