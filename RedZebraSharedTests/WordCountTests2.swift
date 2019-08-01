//
//  WordCountTests2.swift
//  RedZebraSharedTests
//
//  Created by Jan Kříž on 01/08/2019.
//  Copyright © 2019 Jan Kříž. All rights reserved.
//

import XCTest
@testable import RedZebraShared

class WordCountTests2: XCTestCase {
    
    
    let text = "\t\n\n \n \n"
    
    let expectedChars = 7
    let expectedBytes = 7
    let expectedWords = 0
    let expectedLines = 4
    
    var wc: WordCount!
    
    override func setUp() {
        wc = WordCount(text)
    }
    
    
    func testCharacters() {
        XCTAssert(expectedChars == wc.characters)
    }
    
    
    func testBytes() {
        XCTAssert(expectedBytes == wc.bytes)
    }
    
    
    func testWords() {
        XCTAssert(expectedWords == wc.words)
    }
    
    
    func testLines() {
        XCTAssert(expectedLines == wc.lines)
    }
    
}

