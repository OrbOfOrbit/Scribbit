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

class ShareListViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        //Sharing the Lists
        
        //Part 0:   find which list is to be shared:
        //   My guess is that the easiest way to do this is create a global variable that, when a list is designated
        //  to be shared, is set equal to that list's name. For now I will just use a substitute
        var desiredList = globalVariables.listToShare
        
        //Part 1: List all available users
        //      first we want to access all of the available users, listing them by their user names
        //      we will access each user and list their usernames in a tableview
        //      accessing usernames will be done through firebase (some firebase method?)
        //      If there's some firebase method that's purely based on userid then the easiest possible option is
        //  to put all of the userids under users into an array, then put each of the usernames from that userid
        //  into a tableview.
        
        //update:   email seems like a needlessly complicated way of setting this up. I'm going to simplify things
        //  a bit. I'm just going to set up code such that the desired user id is found and then the new list
        //  is added. I'll work with alex to do the tableview part later, because I'd rather not waste a ton of
        //  time relearning tableviews when Alex is already well versed in that, and could probably help me
        //  set it up in around half an hour.
        //      A possible bug I've realized is that if the user were able to add lists to any user id, then
        //  the user could add the same list to their user id... multiple times. I guess I'll resolve this by
        //  checking if the user id selected by the user is the same as their own user id. I'm not going to
        //  set it up so that the user id doesn't appear in the tableview, however, because while that would seem
        //  more sensible, realistically speaking I'm not going to be able to implement that in time. Corners have
        //  to be cut.
        //      It's already 8:35 on the Wednesday before this project is due. I can probably finish this basic
        //  version tonight, with corners cut. Implemeting tableviews will require further work with Alex tomorrow.
        //  I can definitely finish the Share List view controller... But even then, more work has yet to be done.
        //  Bugtests could bring tons of unforseeable changes. Not to mention that we have to implement Aesthetic
        //  changes, which means (A) creating both color themes and (B) implementing a multitude of changes to the
        //  view controllers to make them appealing. To make matters worse, we don't have computer science class
        //  tomorrow and Oron, who is working on aesthetic changes, is preoccupied with players. Even if Oron
        //  somehow manages to finalize the aesthetics, can he implement them on time? If the share list controller
        //  is finished, I can take on implementing the theme changes into every storyboard. Shouldn't be of extreme
        //  difficulty. But we'll see. Either way, we're screwed unless there's a miracle between now and friday.
        //  The only miracle I can concieve of is that Mr. Swope allows us to continue working on the project until
        //  Monday. I feel like I've heard other groups saying they'll need the weekend, but I can neither be sure
        //  nore know if Mr. Swope will even allow them to do so. If we can keep working until Monday, it'd be a
        //  godsend, but even then we'd still need to spend the entirety of Saturday and Sunday working in order
        //  to complete the project.
        
        ref = Database.database().reference()
        
        ref?.child("Users").observe(.value, with: {(snapshot) in
            
            //loop through the children
            var users = [String]()
            
            for child in snapshot.children{
                
                //                print(child)
                
                //set equal to a snapshot (default type is any)
                let childSnap = child as! DataSnapshot
                
                //get the user's username and add it to the array
                if let childID = childSnap.ref.key{
                    
                    //prevent the current user's id from being added to the list (they shouldn't be able
                    //  to share with themselves)
                    if childID != Auth.auth().currentUser?.uid{
                        users.append(childID)
                    }
                }
                
                //                print(users)
                
                
                
            }
            
        })
            .self
        //Part 2: Choose a Useer
        //      once again, refrencing Alex's editlist code, create some sort of button or slider which designates
        //  a user to be shared.
        //      To get which userids need to be shared, we have to do this: take the cell the user selected
        //  and find the corresponding member of the userid array
        
        //we'll use the tableview to do this. for now, we'll just set it manually
        var selectedUser = "dMMqNxkf7BbRaXksq6QaNG0E1ji2"
        
        //Part 3: Share
        //      To share, just upload to firebase under users > the userid we just found > userlists. The name
        //  should be Total_Lists_Created + 1, but the the value should be the list's name (list 1, list2, etc).
        //  We probably have code for adding a list to a user already, I just need to copy that and appropriate it
        //  here
        
        //      If all of that is done it should work. Try to minimize difficulty by using what code is already
        //  written; a lot of this should already exist. Luckily, since ownership isn't differentiated we shouldn't
        //  need to worry about anything else: the list will appear in the user's accessible lists
        
        //      Debugging will probably be very difficult if anything goes wrong. My hope is that because we're
        //  reusing a lot of code this risk should be minimized but you never know. I think that the way we'll have
        //  to test this is by creating a new user with no lists assigned to them, and then sharing them using this
        //  code.
        
        //first we need to make sure that the selected user isn't the user themself
        //        print(Auth.auth().currentUser?.uid)
        if selectedUser != Auth.auth().currentUser?.uid {
            
            //get the total number of userlists
            var totalUserlists = 0
            
            //set total user lists equal to the total number of lists under that user
            ref?.child("Users").child(selectedUser).child("Total_Lists_Created").observeSingleEvent(of: .value, with: { (snapshot) in
                
                totalUserlists = snapshot.value as! Int
                
                
                //alex may have changed this. Alter it so that it works with his code.
                //add one to the total number of userlists
                totalUserlists = totalUserlists + 1
                
                ref?.child("Users").child(selectedUser).child("Total_Lists_Created").setValue(totalUserlists)
                
                //now share by adding it under their firebase
                ref?.child("Users").child(selectedUser).child("UserLists").child("UserList_\(totalUserlists)").setValue(desiredList)
                
            })
            
            
        }
        
        
        
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
