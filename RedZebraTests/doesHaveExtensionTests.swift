//
//  doesHaveExtensionTests.swift
//  RedZebraTests
//
//  Created by Jan Kříž on 05/08/2019.
//  Copyright © 2019 Jan Kříž. All rights reserved.
//

import XCTest
@testable import RedZebra

class doesHaveExtensionTests: XCTestCase {
    
    
    let fileName1 = "hello.txt"
    let fileName2 = "Hello World .md"
    let fileName3 = "hello.world.yaml.md.txt.pdf"
    let fileName4 = "hello_world"
    let fileName5 = "HELLO."
    let fileName6 = "hello.🤬"
    let fileName7 = "hello.   "
    let fileName8 = "hello.Ą"
    let fileName9 = "hello.€"
    let fileName10 = "hello.9"
    
    
    func testFileName1 () {
        XCTAssert(doesHaveExtension(fileName: fileName1) == true)
    }
    
    func testFileName2 () {
        XCTAssert(doesHaveExtension(fileName: fileName2) == true)
    }
    
    func testFileName3 () {
        XCTAssert(doesHaveExtension(fileName: fileName3) == true)
    }
    
    func testFileName4 () {
        XCTAssert(doesHaveExtension(fileName: fileName4) == false)
    }
    
    func testFileName5 () {
        XCTAssert(doesHaveExtension(fileName: fileName5) == false)
    }
    
    func testFileName6 () {
        XCTAssert(doesHaveExtension(fileName: fileName6) == false)
    }
    
    func testFileName7 () {
        XCTAssert(doesHaveExtension(fileName: fileName7) == false)
    }
    
    func testFileName8 () {
        XCTAssert(doesHaveExtension(fileName: fileName8) == false)
    }
    
    func testFileName9 () {
        XCTAssert(doesHaveExtension(fileName: fileName9) == false)
    }
    
    func testFileName10() {
        XCTAssert(doesHaveExtension(fileName: fileName10) == false)
    }
    
}
