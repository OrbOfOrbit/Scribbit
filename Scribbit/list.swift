//
//  list.swift
//  Scribbit
//
//  Created by Alexander Romine (student LM) on 1/30/19.
//  Copyright © 2019 Oron Barash (student LM). All rights reserved.
//

import Foundation
class list {
    var complete:Bool
    var created:Date
    var items:[item]
    var title:String
    init(newitems:[item], newtitle:String, newcreated:Date) {
        created=newcreated
        complete=false
        items=newitems
        title=newtitle
    }
}
