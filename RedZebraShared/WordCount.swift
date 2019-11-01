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
        
        if text.isEmpty {
            return
        }
        
        var isInWord = false
        
        for i in text {
            // count characters
            self.characters += 1

            // count bytes
            if i.isASCII == false {
                self.bytes += i.utf8.count
            } else {
                self.bytes += 1
            }
            
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
        
        
        if text.count > 1 && self.lines == 0 {
            // There may not be \n at the end of a single line,
            // but it's still one line
            self.lines = 1
        } else if text.last != "\n" && text.last != "\r" && text.last != "\0" {
            // This is more than peculiar:
            //
            // If you write something like this in Red Zebra or TextEdit:
            /*
                Hello
                There
                People
            */
            // running wc on the file in terminal says that there are only 2 lines.
            //
            // However, if you the write THE SAME EXACT THING IN SOME TERMINAL EDITOR like vim,
            // and then run wc on that, you get 3 lines...
            //
            // The reason (at least I think) is that vim & other old-school stuff
            // puts either newline or EOF at the end of the file when saving it,
            // but modern text editors don't.
            //
            // That's why I put this check here.
            //
            // For more info, see: https://stackoverflow.com/a/1761086/8742664
            self.lines += 1
        }
        
    }
    
}
