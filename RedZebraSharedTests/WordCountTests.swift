//
//  WordCountTests.swift
//  RedZebraTests
//
//  Created by Jan Kříž on 1/07/2019.
//  Copyright © 2019 Jan Kříž. All rights reserved.
//

import XCTest
@testable import RedZebraShared

class WordCountTests: XCTestCase {
    
    
    let text = """
    Hello there! 😎
    We have a wonderful day/night here, right?
    """
    
    let expectedChars = 57
    let expectedBytes = 60
    let expectedWords = 10
    let expectedLines = 2
    
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
