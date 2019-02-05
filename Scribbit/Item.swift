//
//  Item.swift
//  Scribbit
//
//  Created by Isaac Wetherbee (student LM) on 1/17/19.
//  Copyright © 2019 Oron Barash (student LM). All rights reserved.
//

import Foundation

class Item{
    
    var name: String
    var statis: Bool
    var discription: String
    
    init(name: String, statis: Bool, discription: String) {
        self.name = name
        self.statis = statis
        self.discription = discription
    }
    
}
