//
//  WordCountTests.swift
//  RedZebraTests
//
//  Created by Jan Kříž on 16/06/2019.
//  Copyright © 2019 Jan Kříž. All rights reserved.
//

import XCTest
@testable import RedZebra

class WordCountTests: XCTestCase {
    
    
    let text = """
    Hello there! 😎
    We have a wonderful day/night here, right?

    """
    
    let expectedChars = 58
    let expectedBytes = 61
    let expectedWords = 10
    let expectedLines = 3
    
    let expectedItsTweetable = true
    
    var wc: WordCount!
    
    override func setUp() {
        wc = WordCount(text: text)
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
    
    
    func testItsTweetable() {
        XCTAssert(expectedItsTweetable == wc.itsTweetable)
    }

}
