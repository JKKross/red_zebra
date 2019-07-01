//
//  IntExtension.swift
//  Red Zebra
//
//  Created by Jan Kříž on 23/05/2019.
//  Copyright © 2019 Jan Kříž. All rights reserved.
//

extension Int {
    
    func asFormattedString() -> String {
        
        var input = String(self)
        
        if input.count <= 3 { return input }
        
        var charArray = [Character]()
        var output = ""
        
        for _ in input {
            charArray.append(input.removeFirst())
        }
        
        var counter = 0
        // I can actually do the "charArray.count + 1" here safely,
        // because we are ADDING elements to the array and the condition
        // in the for loop is evaluated only before it starts
        //
        // yep. It's hacky. Sue me.
        for i in 0...charArray.count + 1 {
            
            if counter == 3 {
                counter = 0
                charArray.insert(" ", at: charArray.count - i)
            } else {
                counter += 1
            }
            // tbh, it works "only" before we reach trillions - but hey,
            // this is supposed to be used only within the WordCount pop-up.
            // And if someone has over a trillion characters or god forbid words or
            // even lines - THEY DON'T DESERVE NICELY FORMATTED NUMBERS! 😜
        }
        
        for i in charArray {
            output.append(i)
        }
        
        if output.first == " " {
            output.removeFirst()
        }
        
        return output
    }
    
}
