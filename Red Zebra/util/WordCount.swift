//
//  WordCount.swift
//  Red Zebra
//
//  Created by Jan Kříž on 22/05/2019.
//  Copyright © 2019 Jan Kříž. All rights reserved.
//


struct WordCount {
    
    var characters: Int
    var words:      Int
    var lines:      Int
    
    var itsTweetable: Bool
    
    
    init(text: String) {
        
        var words = text.split(separator: " ")
        
        // The following may seem like black magic, but it works, so DON'T TOUCH IT!!!
        for i in 0..<words.count {
            
            while words[i].contains("\n") {
                
                if words[i].first == "\n" {
                    
                    words[i].removeFirst()
                    
                } else if words[i].last == "\n" {
                    
                    words[i].removeLast()
                    
                } else {
                    
                    let newWords = words[i].split(separator: "\n")
                    words[i].removeAll()
                    
                    for i in newWords {
                        words.append(i)
                    }
                    
                }
                
            }
        }
        
        words.removeAll(where: { $0 == "" })
        
        
        self.characters = text.count
        self.words      = words.count
        self.lines      = 0
        
        self.itsTweetable = false
        
        if text.isEmpty {
            return
        } else {
            // otherwise we get one line less (from our human perspective)
            self.lines += 1
        }
        
        
        for i in text {
            if i == "\n" {
                self.lines += 1
            }
        }
        
        if self.characters < 280 {
            self.itsTweetable = true
        }
        
    }
    
    
}
