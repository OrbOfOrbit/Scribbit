//
//  list.swift
//  Scribbit
//
//  Created by Alexander Romine (student LM) on 1/17/19.
//  Copyright © 2019 Oron Barash (student LM). All rights reserved.
//

import Foundation
class list{
   public var done:Bool
   public var text:String
    public var title:String
   public var sublist:list?
    init(newtitle:String, newsublist:list, newtext:String ,newdone:Bool ) {
        done = newdone
        text = newtext
        sublist = newsublist
        title = newtitle
    }
    
}
