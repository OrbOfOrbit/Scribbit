//
//  newitem.swift
//  Scribbit
//
//  Created by Alexander Romine (student LM) on 3/11/19.
//  Copyright © 2019 Oron Barash (student LM). All rights reserved.
//

import Foundation
class newitem{
    var done:Bool//the value
    var type:Bool//whether or not it is a list or another item.
    var value:String
    var stuff="gaming"
    
    init(newdone:Bool,newtype:Bool,newvalue:String) {
        done = newdone
        type = newtype
        value = newvalue
        
    }
}
