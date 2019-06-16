//
//  IntAsFormattedStringTests.swift
//  RedZebraTests
//
//  Created by Jan Kříž on 16/06/2019.
//  Copyright © 2019 Jan Kříž. All rights reserved.
//

import XCTest
@testable import RedZebra

class IntAsFormattedStringTests: XCTestCase {

    
    let intToFormat = 23_004_348_739
    let expectedFormattedString = "23 004 348 739"
    
    
    func testIsFormattedProperly() {
        XCTAssert(intToFormat.asFormattedString() == expectedFormattedString)
    }

}
