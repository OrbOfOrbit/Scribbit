//
//  user.swift
//  Scribbit
//
//  Created by Justin Cannan (student LM) on 4/24/19.
//  Copyright © 2019 Oron Barash (student LM). All rights reserved.
//

import Foundation
import FirebaseAuth

class user{
    var userID:String?
    var email:String?
    
    init(userID:String?, email:String?) {
        self.userID = userID
        self.email = email
    }
}
