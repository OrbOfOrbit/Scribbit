//
//  SignUpViewController.swift
//  Scribbit
//
//  Created by Isaac Wetherbee (student LM) on 1/29/19.
//  Copyright © 2019 Oron Barash (student LM). All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase


class SignUpViewController: UIViewController {

    @IBOutlet weak var userNameTextFeild: UITextField!
    
    @IBOutlet weak var EmailTextFeild: UITextField!
    
    @IBOutlet weak var passwordTextFeild: UITextField!
    
    @IBAction func signUpButtonClicked(_ sender: UIButton) {
        
        
        Auth.auth().createUser(withEmail: EmailTextFeild.text!, password: passwordTextFeild.text!){
            user, error in
            if let _ = user {
                print("user created")
            }else{
                print(error.debugDescription)
            }
        }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    

}
