//
//  newlistViewController.swift
//  Scribbit
//
//  Created by Alexander Romine (student LM) on 4/24/19.
//  Copyright © 2019 Oron Barash (student LM). All rights reserved.
//
import UIKit
import FirebaseDatabase
import FirebaseAuth
class newlistViewController: UIViewController, UITextFieldDelegate {
    var ref:DatabaseReference?
    var num = 1
    var totallist=1
    var stringiterator="List_1"
    var useriterator="UserList_1"
    let id = (Auth.auth().currentUser?.uid)!
    @IBAction func create(_ sender: UIButton) {
        getnumber(completion: {(l) in
            self.getlist(completion: {(p) in
       
                self.ref?.child("Lists").child(self.stringiterator).child("Name").setValue(self.textfield.text ?? "untitled list")
                self.ref?.child("Users").child(self.id).child("UserLists").child(self.useriterator).setValue(self.stringiterator)
                
            })
        })
        self.ref!.child("Users").child(id).observeSingleEvent(of:.value, with: {(snapshot) in
            
            var l = snapshot.childSnapshot(forPath: "Total_Lists_Created").value as! Int
            l = l + 1
            self.ref?.child("Users").child(self.id).child("Total_Lists_Created").setValue(l)
            
            
        })
        self.ref!.child("Lists").observeSingleEvent(of:.value, with: {(snapshot) in
            
            var l = snapshot.childSnapshot(forPath: "Total_Lists_Created").value as! Int
            l = l + 1
            self.ref?.child("Lists").child("Total_Lists_Created").setValue(l)
            
            
        })
        
        
        
        self.dismiss(animated: false, completion: nil)
    }
    //this function is just a neat trick i leanred no make firebase complete in sync instead of asynchornously, it just gets the next usable number for list sorting.
    func getnumber (completion: @escaping (Bool) -> ()){
        
        ref!.child("Lists").observeSingleEvent(of:.value, with: {(snapshot) in
            while (snapshot.childSnapshot(forPath: self.stringiterator).exists()){
                self.num = self.num + 1
                self.stringiterator = String(self.stringiterator.dropLast())
                self.stringiterator.append(String(self.num))
                
            }
            completion(true)
        })


        
        
    }
    //this does the same thing, but for lists the user is allowed to acsess.
    func getlist (completion: @escaping (Bool) -> ()){
        
        ref!.child("Users").child(id).child("UserLists").observeSingleEvent(of:.value, with: {(snapshot) in
            while (snapshot.childSnapshot(forPath: self.useriterator).exists()){
                self.totallist = self.totallist + 1
                self.useriterator = String(self.useriterator.dropLast())
                self.useriterator.append(String(self.totallist))
                
            }
            completion(true)
        })
        
        
    }
    @IBOutlet weak var textfield: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        
        textfield.delegate = self
        // Do any additional setup after loading the view.
    }
    
    
    /*
     // MARK: - Navigation
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        //or
        //self.view.endEditing(true)
        return true
        
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
    
        textField.becomeFirstResponder()
    }
    
}
