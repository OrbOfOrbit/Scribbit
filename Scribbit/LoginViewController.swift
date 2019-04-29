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
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBAction func goBack(_ sender: Any) {
        presentingViewController?.dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        userNameTextField.delegate = self
       passwordTextField.delegate = self
        DispatchQueue.main.async {
          //  self.userNameTextField.becomeFirstResponder()
        }
    }
    
    @IBAction func loginButtonTouchedUpInside(_ sender: Any) {
        guard let emailAddress = userNameTextField.text else{return}
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
    
 /*   func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if userNameTextField.isFirstResponder{
            passwordTextField.becomeFirstResponder()
        }
        else{
            passwordTextField.resignFirstResponder()
            loginButton.isEnabled = true
        }
        
        return true;
    }*/
}
