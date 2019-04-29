//
//  TextField.swift
//  Scribbit
//
//  Created by Justin Cannan (student LM) on 4/28/19.
//  Copyright © 2019 Oron Barash (student LM). All rights reserved.
//

import UIKit

class TextField: UITextField {

    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        //or
        //self.view.endEditing(true)
        return true
    }

    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
