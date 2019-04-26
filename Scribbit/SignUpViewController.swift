//
//  SignUpViewController.swift
//  Scribbit
//
//  Created by Oron Barash (student LM) on 1/18/19.
//  Copyright © 2019 Oron Barash (student LM). All rights reserved.
//
import UIKit
import FirebaseAuth
import FirebaseDatabase
class SignUpViewController: UIViewController, UITextFieldDelegate{
    
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var emailAddressTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        userNameTextField.delegate = self
        emailAddressTextField.delegate = self
        passwordTextField.delegate = self
        userNameTextField.becomeFirstResponder()
    }
    
    @IBAction func signUpButtonTouchedUp(_ sender: Any) {
        print("test")
        guard let userName = userNameTextField.text else{return}
        guard let emailAddress = emailAddressTextField.text else{return}
        guard let password = passwordTextField.text else{return}
        
        Auth.auth().createUser(withEmail: emailAddress, password: password, completion: { (user, error) in
            
            if let _ = user {
                
                print("user created")
                
                let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
                
                changeRequest?.displayName = userName
                changeRequest?.commitChanges(completion: { (error) in
                    
                    print("couldn't change name")
                    
                })
               var id = Auth.auth().currentUser?.uid
                ref?.child("Users").child(id!).child("Name").setValue(userName)
                self.dismiss(animated: true, completion: nil)
            }
                
            else{
                
                print(error.debugDescription)
                
            }
            
        })
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if userNameTextField.isFirstResponder{
            emailAddressTextField.becomeFirstResponder()
        }
        else if emailAddressTextField.isFirstResponder{
            passwordTextField.becomeFirstResponder()
        }
        else{
            passwordTextField.resignFirstResponder()
            signUpButton.isEnabled = true
        }
        
        return true;
    }
}
