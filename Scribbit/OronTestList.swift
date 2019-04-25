//
//  OronTestList.swift
//  Scribbit
//
//  Created by Oron Barash (student LM) on 3/11/19.
//  Copyright © 2019 Oron Barash (student LM). All rights reserved.
//
import Foundation
import FirebaseDatabase

class OronTestList {
    
    var name : String
    var num  : String
    //    var contributors = [String]()
    //    var dateCreated : Date
    //    var items = [String]()
    
    //    convenience init(){
    //        self.init("Untitled")
    //    }
    
    init(_ snap: String, listname:String){
        var ref = Database.database().reference()
        var name = "Loading"
        var num = ""
        num = listname
        name = snap
        self.name = name
        self.num = num
    }
}
