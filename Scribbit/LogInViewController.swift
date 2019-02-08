//
//  LogInViewController.swift
//  Scribbit
//
//  Created by Isaac Wetherbee (student LM) on 1/29/19.
//  Copyright © 2019 Oron Barash (student LM). All rights reserved.
//

import UIKit
import FirebaseAuth
class LogInViewController: UIViewController, UITextFieldDelegate{

    @IBOutlet weak var userNameTextFeild: UITextField!
    
    @IBOutlet weak var passwordTextFeild: UITextField!
    
    @IBAction func logInButtonClicked(_ sender: UIButton) {
        
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userNameTextFeild.delegate = self
        passwordTextFeild.delegate = self
        userNameTextFeild.isFirstResponder
        
    }

    
    

   

}
