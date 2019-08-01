//
//  WordCountTests3.swift
//  RedZebraSharedTests
//
//  Created by Jan Kříž on 01/08/2019.
//  Copyright © 2019 Jan Kříž. All rights reserved.
//

import XCTest
@testable import RedZebraShared

class WordCountTests3: XCTestCase {
    
    
    let text = """
    
    
    This is
    a test
    for
    
    word
    \t count
    """
    
    let expectedChars = 34
    let expectedBytes = 34
    let expectedWords = 7
    let expectedLines = 8
    
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
