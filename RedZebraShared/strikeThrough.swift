//
//  strikeThrough.swift
//  RedZebraShared
//
//  Created by Jan Kříž on 01/08/2019.
//  Copyright © 2019 Jan Kříž. All rights reserved.
//

func strikeThrough(_ text: String) -> String {
    
    var input = text
    var output = ""
    
    for _ in input {
        output.append(input.removeFirst())
        if output.last!.isLetter || output.last!.isNumber {
            output.append("\u{0336}")
        }
    }
    
    return output
}
