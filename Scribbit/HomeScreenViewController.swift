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
    var nam:String?
    var listData = [OronTestList]()
    var ref: DatabaseReference?
    var databaseHandle: DatabaseHandle?
    var userListsDisplayed = 0
    var totalUserLists = 0
    @objc func longtap(recognizer: UITapGestureRecognizer){
        
        if recognizer.state == UIGestureRecognizerState.ended {
            let tapLocation = recognizer.location(in: self.listTableView)
            if let tapIndexPath = self.listTableView.indexPathForRow(at: tapLocation) {
                 globalVariables.listToShare = listData[tapIndexPath.row].num
                let board = UIStoryboard(name: "ShareList", bundle: self.nibBundle)
                let controller = board.instantiateInitialViewController() as! ShareListViewController 
                self.present(controller,animated: false)
            }
        }
    }
    @IBAction func signOut(_ sender: UIButton) {
        try! Auth.auth().signOut()
        self.dismiss(animated:false, completion: nil)
    }
    
    @IBAction func newlist(_ sender: Any) {
        listData = [OronTestList]()
        let board = UIStoryboard(name: "newlist", bundle: self.nibBundle)
        let controller = board.instantiateInitialViewController() as! newlistViewController
        self.present(controller, animated: false)
    }
    func newuser(id:String){
        let snapshot = ref!.child("Users").child(id)
        var maxlist = 1
        var stringiterator = "List_1"
        snapshot.child("Total_Lists_Created").setValue(1)
        ref?.child("Lists").observe(.value, with: {(snapshot) in
            
            
            while (snapshot.childSnapshot(forPath: stringiterator).exists()){
                maxlist = maxlist + 1
                
                stringiterator = String(stringiterator.dropLast())
                stringiterator.append(String(maxlist))
            }})
        stringiterator = String(stringiterator.dropLast())
        stringiterator.append(String(maxlist+2))
        
        snapshot.child("UserLists").child("Userlist_1").setValue(stringiterator)
        let b = ref?.child("Lists").child(stringiterator)
        b?.child("Name").setValue("welcome to scribbit!")
        let formatteddate = DateFormatter()
        formatteddate.dateStyle = .long
        formatteddate.timeStyle = .long
        b?.child("Last_Edited").setValue(formatteddate.string(from: Date.init()))
    }
    override func viewDidLoad() {
        let longrecon = UILongPressGestureRecognizer(target: self, action: #selector(longtap))
        listTableView.addGestureRecognizer(longrecon)
        listTableView.backgroundColor = hexStringToUIColor(hex: "53C9F4")
        super.viewDidLoad()
        view.backgroundColor = hexStringToUIColor(hex: "53C9F4")
        ref = Database.database().reference()
        
        listTableView.delegate = self
        listTableView.dataSource = self
        
        let id = (Auth.auth().currentUser?.uid)!
        
        ref?.child("Users").child(id).child("Total_Lists_Created").observe(.value, with: {(snapshot) in
            if snapshot.exists(){
                self.totalUserLists = (snapshot.value as? Int)!
            }
            else {
                self.newuser(id: id)
            }
        })
        ref?.child("Users").child(id).child("UserLists").observe(.value, with: {(snapshot) in
            self.listData=[OronTestList]()
            var stringiterator = "UserList_1"
            var i = 1
            while snapshot.childSnapshot(forPath: stringiterator).exists(){
                let veter = snapshot.childSnapshot(forPath: stringiterator).value as! String
                
                let list = OronTestList(veter, listname: veter)
                self.listData.append(list)
                DispatchQueue.main.async {
                    self.listTableView.reloadData()
                }
                self.userListsDisplayed += 1
                i = i + 1
                
                stringiterator = String(stringiterator.dropLast())
                stringiterator.append(String(i))
            }
            DispatchQueue.main.async {
                self.listTableView.reloadData()
            }
            
            
            
        })
        
        //ref?.observe(.value, with: {(snapshot) in
        /* for i in self.userListsDisplayed..<self.totalUserLists{
         if(snapshot.childSnapshot(forPath: "Users").childSnapshot(forPath: id).childSnapshot(forPath: "UserLists").childSnapshot(forPath: "UserList_\(i+1)").exists()){
         let List = OronTestList(snapshot.childSnapshot(forPath: "Lists").childSnapshot(forPath: (snapshot.childSnapshot(forPath: "Users").childSnapshot(forPath: id).childSnapshot(forPath: "UserLists").childSnapshot(forPath: "UserList_\(i+1)").value as? String)!), listname: "List_\(i+1)")
         self.listData.append(List)
         self.listTableView.reloadData()
         self.userListsDisplayed += 1
         }
         
         }*/
        
        
        //})
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListTableCell")
        cell?.backgroundColor = hexStringToUIColor(hex: "53C9F4")
        someMethod(completion: {(gamer) in
            cell?.textLabel?.text = self.nam
        } , i: indexPath.row)
        cell?.textLabel?.text="loading"
        return cell!
        
        
    }
    func someMethod(completion: @escaping (Bool) -> (), i:Int){
        ref?.child("Lists").child(listData[i].name).observe (.value, with: {(snapshot:DataSnapshot) in
            self.nam = snapshot.childSnapshot(forPath: "Name").value as! String
            
            completion(true)
        })
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let board = UIStoryboard(name: "list", bundle: self.nibBundle)
        let controller = board.instantiateInitialViewController() as! neweditController
        controller.dataget = (listData[indexPath.row].num)
        self.present(controller,animated: false)
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
