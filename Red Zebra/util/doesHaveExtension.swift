//
//  doesHaveExtension.swift
//  Red Zebra
//
//  Created by Jan Kříž on 05/08/2019.
//  Copyright © 2019 Jan Kříž. All rights reserved.
//

public func doesHaveExtension(fileName: String) -> Bool {
    var file = fileName
    for _ in file {
        let searchingForDot = file.removeFirst()
        if searchingForDot == "." {
            for _ in file {
                let ext = file.removeFirst()
                if ext.isLetter == false {
                    return false
                }
            }
            return true
        }
    }
    return false
}
