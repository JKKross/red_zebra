//
//  doesHaveExtension.swift
//  Red Zebra
//
//  Created by Jan Kříž on 05/08/2019.
//  Copyright © 2019 Jan Kříž. All rights reserved.
//

public func doesHaveExtension(fileName: String) -> Bool {
    // get rid of the possibility of the file ending with a dot
    if fileName.last! == "." { return false }
    
    for i in fileName.reversed() {
        if (i.isASCII == false || i.isLetter == false) && i != "." {
            return false
        } else if i == "." {
            return true
        }
    }
    // if we're here, something obviously went wrong,
    // but Swift requires me to return what I promised
    return false
}
