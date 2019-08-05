//
//  StrikeThroughTests.swift
//  RedZebraSharedTests
//
//  Created by Jan Kříž on 01/08/2019.
//  Copyright © 2019 Jan Kříž. All rights reserved.
//

import XCTest
@testable import RedZebraShared

class StrikeThroughTests: XCTestCase {
    
    
    let input1 = "Hello, world!"
    let input2 = " 42 "
    let input3 = "Hello! 😎 How are you?"
    
    let expectedOutput1 = "H̶e̶l̶l̶o̶, w̶o̶r̶l̶d̶!"
    let expectedOutput2 = " 4̶2̶ "
    let expectedOutput3 = "H̶e̶l̶l̶o̶! 😎 H̶o̶w̶ a̶r̶e̶ y̶o̶u̶?"
    
    
    func test1() {
        XCTAssert(strikeThrough(input1) == expectedOutput1)
    }
    
    func test2() {
        XCTAssert(strikeThrough(input2) == expectedOutput2)
    }
    
    func test3() {
        XCTAssert(strikeThrough(input3) == expectedOutput3)
    }
    
}
