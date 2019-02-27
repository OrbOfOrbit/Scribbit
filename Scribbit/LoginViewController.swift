//
//  LoginViewController.swift
//  Scribbit
//
//  Created by Oron Barash (student LM) on 1/16/19.
//  Copyright © 2019 Oron Barash (student LM). All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController, UITextFieldDelegate{

    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTextField.delegate = self
        passwordTextField.delegate = self
        emailTextField.becomeFirstResponder()
    }
    
    @IBAction func loginButtonTouchedUpInside(_ sender: Any) {
        guard let emailAddress = emailTextField.text else{return}
        guard let password = passwordTextField.text else{return}
        
        Auth.auth().signIn(withEmail: emailAddress, password: password) { (user, error)
            in
            
            if error == nil && user != nil{
                
                self.dismiss(animated: false, completion: nil)
                
            }
                
            else{
                
                print(error!.localizedDescription)
                
            }
            
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if emailTextField.isFirstResponder{
            passwordTextField.becomeFirstResponder()
        }
        else{
            passwordTextField.resignFirstResponder()
            loginButton.isEnabled = true
        }
        
        return true;
    }
}
