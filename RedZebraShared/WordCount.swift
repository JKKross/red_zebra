//
//  WordCount.swift
//  Red Zebra
//
//  Created by Jan Kříž on 22/05/2019.
//  Copyright © 2019 Jan Kříž. All rights reserved.
//

public struct WordCount {
    
    public private(set) var words = 0
    public private(set) var lines = 0
    public private(set) var characters = 0
    public private(set) var bytes = 0
    
    
    public init(_ text: String) {
        
        if text.count == 0 {
            return
        } else if text.count > 1 {
            // There may not be \n at the end of a single line,
            // but it's still one line
            self.lines += 1
        }
        // count characters
        self.bytes = text.utf8.count
        self.characters = text.count
        
        var isInWord = false
        
        for i in text {
            // count lines
            if i.isNewline {
                self.lines += 1
            }
            
            // count words
            if i.isWhitespace == false && isInWord == false {
                self.words += 1
                isInWord = true
            } else if i.isWhitespace && isInWord {
                isInWord = false
            }
        }
        
    }
    
}
