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
    //    var contributors = [String]()
    //    var dateCreated : Date
    //    var items = [String]()
    
    //    convenience init(){
    //        self.init("Untitled")
    //    }
    
    init(_ snap: DataSnapshot){
        var name = "Untitled"
        
        name = (snap.childSnapshot(forPath: "Name").value as? String)!
        //        .child("Name").observeSingleEvent(of: .value, with: {(snapshot) in
        //
        //            print("test")
        //            name = (snapshot.value as? String)!
        //
        //        })
        
        self.name = name
    }
}
