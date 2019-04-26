//
//  ShareListViewController.swift
//  Scribbit
//
//  Created by Justin Cannan (student LM) on 4/22/19.
//  Copyright © 2019 Oron Barash (student LM). All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

var ref:DatabaseReference?
var handle:DatabaseHandle?

class ShareListViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    //creates the tableview that shows each user
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "shamer", for: indexPath)
        ref?.child("Users").observeSingleEvent(of: .value, with: {(snapshot) in
            
            cell.textLabel?.text = snapshot.childSnapshot(forPath: self.users[indexPath.row]).childSnapshot(forPath: "Name").value as! String

        })
       
        return cell
    }
     var desiredList = globalVariables.listToShare
      var selectedUser = ""
      var users = [String]()
    @IBAction func share(_ sender: Any) {
        if selectedUser != Auth.auth().currentUser?.uid {
            
            //get the total number of userlists
            var totalUserlists = 0
            
            //set total user lists equal to the total number of lists under that user
            ref?.child("Users").child(selectedUser).child("Total_Lists_Created").observeSingleEvent(of: .value, with: { (snapshot) in
                
                totalUserlists = snapshot.value as! Int
                
                
                //alex may have changed this. Alter it so that it works with his code.
                //add one to the total number of userlists
                totalUserlists = totalUserlists + 1
                
                ref?.child("Users").child(self.selectedUser).child("Total_Lists_Created").setValue(totalUserlists)
                
                //now share by adding it under their firebase
                ref?.child("Users").child(self.selectedUser).child("UserLists").child("UserList_\(totalUserlists)").setValue(self.desiredList)
                self.dismiss(animated: true, completion: nil)
            })
            
            
            
        }
    }
    @IBAction func cancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBOutlet weak var tableview: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        //Sharing the Lists
        
        //Part 0:   find which list is to be shared:
        //   My guess is that the easiest way to do this is create a global variable that, when a list is designated
        //  to be shared, is set equal to that list's name. For now I will just use a substitute
       
        
        //Part 1: List all available users
        //      first we want to access all of the available users, listing them by their user names
        //      we will access each user and list their usernames in a tableview
        //      accessing usernames will be done through firebase (some firebase method?)
        //      If there's some firebase method that's purely based on userid then the easiest possible option is
        //  to put all of the userids under users into an array, then put each of the usernames from that userid
        //  into a tableview.
        
        
        ref = Database.database().reference()
        
        ref?.child("Users").observe(.value, with: {(snapshot) in
            
            //loop through the children
          
            
            for child in snapshot.children{
                
                //                print(child)
                
                //set equal to a snapshot (default type is any)
                let childSnap = child as! DataSnapshot
                
                //get the user's username and add it to the array
                if let childID = childSnap.ref.key{
                    
                    //prevent the current user's id from being added to the list (they shouldn't be able
                    //  to share with themselves)
                    if childID != Auth.auth().currentUser?.uid{
                        self.users.append(childID)
                    }
                }
                
                //                print(users)
                
                
                
            }
            DispatchQueue.main.async {
                self.tableview.reloadData()
            }
            
           
        })
        
            .self
        //Part 2: Choose a Useer
        //      once again, refrencing Alex's editlist code, create some sort of button or slider which designates
        //  a user to be shared.
        //      To get which userids need to be shared, we have to do this: take the cell the user selected
        //  and find the corresponding member of the userid array
        
        //we'll use the tableview to do this. for now, we'll just set it manually
      
        
        //Part 3: Share
        //      To share, just upload to firebase under users > the userid we just found > userlists. The name
        //  should be Total_Lists_Created + 1, but the the value should be the list's name (list 1, list2, etc).
        //  We probably have code for adding a list to a user already, I just need to copy that and appropriate it
        //  here
        
        
        //first we need to make sure that the selected user isn't the user themself
        //        print(Auth.auth().currentUser?.uid)
      
        
        
        
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedUser = users[indexPath.row]
    }
}
