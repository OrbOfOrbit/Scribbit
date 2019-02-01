//
//  item.swift
//  Scribbit
//
//  Created by Alexander Romine (student LM) on 1/30/19.
//  Copyright © 2019 Oron Barash (student LM). All rights reserved.
//

import Foundation
class item{
     var done:Bool
     var content:String
     var subitems:[item]
    init(newcontent:String, newdone:Bool, newsubitems:[item]) {
        done = newdone
        content = newcontent
        subitems = newsubitems
    }
}
