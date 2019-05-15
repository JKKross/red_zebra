//
//  CountLines_StringExtension.swift
//  Red Zebra
//
//  Created by Jan Kříž on 12/05/2019.
//  Copyright © 2019 Jan Kříž. All rights reserved.
//

extension String {

    func countAllLines() -> Int {
        
        if self.isEmpty { return 0 }
        
        var total = 1
        
        for i in self {
            if i.isNewline {
                total += 1
            }
        }
        
        return total
    }

}
