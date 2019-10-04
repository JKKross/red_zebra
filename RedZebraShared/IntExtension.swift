//
//  IntExtension.swift
//  Red Zebra
//
//  Created by Jan Kříž on 23/05/2019.
//  Copyright © 2019 Jan Kříž. All rights reserved.
//

extension Int {
    
    func asFormattedString() -> String {
        
        let input = String(self)
        if input.count < 4 { return input }
        
        var output = ""
        var counter = 0
        
        for i in input.reversed() {
            counter += 1
            output.append(i)
            
            if counter == 3 { 
                output.append(" ")
                counter = 0
            }
        }
        
        output = String(output.reversed())
        
        if output.first == " " {
            output.removeFirst()
        }
        return output
    }
}
