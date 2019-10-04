//
//  BinaryIntegerAsFormattedStringTests.swift
//  RedZebraSharedTests
//
//  Created by Jan Kříž on 04/10/2019.
//  Copyright © 2019 Jan Kříž. All rights reserved.
//

import XCTest
@testable import RedZebraShared

class IntAsFormattedStringTests: XCTestCase {
    
    func testIntIsFormattedProperly() {
        let Int_ToFormat: Int = -23_004_348_739
        let Int_expectedFormattedString = "-23 004 348 739"
        
        XCTAssert(Int_ToFormat.asFormattedString() == Int_expectedFormattedString)
    }
    
    
    func testUIntIsFormattedProperly() {
        let Int_ToFormat: UInt = 23_004_348_739
        let Int_expectedFormattedString = "23 004 348 739"
        
        XCTAssert(Int_ToFormat.asFormattedString() == Int_expectedFormattedString)
    }
    
    
    func testInt32IsFormattedProperly() {
        let Int_ToFormat: Int32 = -4_348_739
        let Int_expectedFormattedString = "-4 348 739"
        
        XCTAssert(Int_ToFormat.asFormattedString() == Int_expectedFormattedString)
    }
    
    
    func testUInt16IsFormattedProperly() {
        let Int_ToFormat: UInt16 = 48_739
        let Int_expectedFormattedString = "48 739"
        
        XCTAssert(Int_ToFormat.asFormattedString() == Int_expectedFormattedString)
    }
    
    
    func testInt8IsFormattedProperly() {
        let Int_ToFormat: Int8 = -23
        let Int_expectedFormattedString = "-23"
        
        XCTAssert(Int_ToFormat.asFormattedString() == Int_expectedFormattedString)
    }
    
}
