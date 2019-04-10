//
//  HomeScreenViewController.swift
//  Scribbit
//
//  Created by Oron Barash (student LM) on 3/11/19.
//  Copyright © 2019 Oron Barash (student LM). All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class HomeScreenViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    @IBOutlet weak var listTableView: UITableView!
    
    var listData = [OronTestList]()
    var ref: DatabaseReference?
    var databaseHandle: DatabaseHandle?
    var userListsDisplayed = 0
    var totalUserLists = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference()
        
        listTableView.delegate = self
        listTableView.dataSource = self
        
        let id = (Auth.auth().currentUser?.uid)!
        
        ref?.child("Users").child(id).child("Total_Lists_Created").observe(.value, with: {(snapshot) in
            self.totalUserLists = (snapshot.value as? Int)!
        })
        
        ref?.observe(.value, with: {(snapshot) in
            for i in self.userListsDisplayed..<self.userListsDisplayed{
                if(snapshot.childSnapshot(forPath: "Users").childSnapshot(forPath: id).childSnapshot(forPath: "UserLists").childSnapshot(forPath: "UserList_\(i+1)").exists()){
                    let List = OronTestList(snapshot.childSnapshot(forPath: "Lists").childSnapshot(forPath: (snapshot.childSnapshot(forPath: "Users").childSnapshot(forPath: id).childSnapshot(forPath: "UserLists").childSnapshot(forPath: "UserList_\(i+1)").value as? String)!))
                    self.listData.append(List)
                    self.listTableView.reloadData()
                    self.userListsDisplayed += 1
                }
                
            }
            
        })
        

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListTableCell")
        cell?.textLabel?.text = listData[indexPath.row].name
        
        return cell!
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
