//
//  newlist.swift
//  Scribbit
//
//  Created by Alexander Romine (student LM) on 3/11/19.
//  Copyright © 2019 Oron Barash (student LM). All rights reserved.
//

import Foundation
class newlist {
    var created:Date//the date when it was last acsessed,
    var items:[newitem]//the collection of items in the list
    var title:String//the title of the list
    init(newitems:[newitem], newtitle:String, newcreated:Date) {
        created=newcreated
        items=newitems
        title=newtitle
    }
}
