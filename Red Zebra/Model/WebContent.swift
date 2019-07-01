//
//  WebContent.swift
//  Red Zebra
//
//  Created by Jan Kříž on 24/05/2019.
//  Copyright © 2019 Jan Kříž. All rights reserved.
//
import Foundation

struct WebContent {
    
    var data: String
    var url:  URL?
    
    init(data: String, url: URL?) {
        self.data = data
        self.url  = url
    }
    
}
