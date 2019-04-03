//
//  ItemDisplayViewController.swift
//  Scribbit
//
//  Created by Isaac Wetherbee (student LM) on 3/15/19.
//  Copyright © 2019 Oron Barash (student LM). All rights reserved.
//

import UIKit
import FirebaseDatabase

class ItemDisplayViewController: UIViewController {
    @IBOutlet weak var NavigationBar: UINavigationBar!
    
    @IBOutlet weak var TextFeild: UITextView!
    
    var ref: DatabaseReference?
    
    var databaseHandle:DatabaseHandle?
    var postData = [String]()
    
    

    
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        //color stuff
         view.backgroundColor = colorChoices.bgColor
        TextFeild.backgroundColor = colorChoices.fgColor
        //end of color stuff

        ref = Database.database().reference()
        
        

       
        
        ref?.child("Lists").child("List_1").child("Items").child("Item_1").observe(.value, with: { (snapshot) in
            let title = snapshot.childSnapshot(forPath: "Name").value as? String
            self.NavigationBar.topItem?.title = title
            
            
            var post = snapshot.childSnapshot(forPath: "Value").value as? String
            
            var postedit = post!
            
            postedit.remove(at: postedit.startIndex)
            postedit.remove(at: postedit.startIndex)
            postedit.remove(at: postedit.startIndex)
            
            self.TextFeild.text = postedit
            
            
            
        })
        
        
        
        
     
        
    
    }


    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

   

}
