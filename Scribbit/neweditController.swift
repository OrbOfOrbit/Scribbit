//
//  neweditController.swift
//  Scribbit
//
//  Created by Alexander Romine (student LM) on 3/11/19.
//  Copyright © 2019 Oron Barash (student LM). All rights reserved.
//

import UIKit
import FirebaseDatabase

class neweditController: UITableViewController {
    @IBOutlet var tableview: UITableView!
    var ref:DatabaseReference?
    var handle:DatabaseHandle?
    var basicitem = newitem(newdone: false, newtype: false, newvalue: "mama mia")
    var basicitem2 = newitem(newdone: false, newtype: false, newvalue: "papa mia")
    var basiclist:newlist?
    var listdate = [String]()
    var dataget="List_1"
    override func viewDidLoad() {
        tableView.delegate = self
        tableView.dataSource = self
        let longrecon = UILongPressGestureRecognizer(target: self, action: #selector(mamamia))
        tableview.addGestureRecognizer(longrecon)
        super.viewDidLoad()
        basiclist = newlist(newitems: [newitem](), newtitle: "", newcreated: Date.init())
       tableview.isEditing=true
        tableview.allowsSelectionDuringEditing = true
        ref = Database.database().reference()
        ref?.child("Lists").child(dataget).child("Items").observe(.value, with: {(snapshot) in
            var gamer = "Item_1"
            var i = 1
            while (snapshot.childSnapshot(forPath: gamer).exists()){
               // print(snapshot.childSnapshot(forPath: gamer).children.allObjects)
              
                var isdone:Bool
                print(i)
                if (snapshot.childSnapshot(forPath: gamer).childSnapshot(forPath: "Value").value as? String)!.first == "%"{
                  
                  let  p = (snapshot.childSnapshot(forPath: gamer).childSnapshot(forPath: "Value").value as? String)!.split(separator: "%")[0]
                    print(p)
                let b = Int(String(p))
                    isdone = (b)! == 1}
                else {isdone = false}
            
                    let additem = newitem(newdone: isdone, newtype: (snapshot.childSnapshot(forPath: gamer).childSnapshot(forPath: "Type").value as? Bool)!, newvalue: (snapshot.childSnapshot(forPath: gamer).childSnapshot(forPath: "Name").value as? String)!)
                additem.stuff = (snapshot.childSnapshot(forPath: gamer).childSnapshot(forPath: "Value").value as? String)!
                    self.basiclist?.items.append(additem)
                    
                
                
                
                i = i + 1
               
                gamer = String(gamer.dropLast())
                gamer.append(String(i))
                //print(gamer)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    
                    //for testing purposes. Delete once a proper button has been added
                    //post to firebase
                    //                self.ref?.child("Lists").childByAutoId().setValue(self.basiclist.items)
                }
            }
            
            
            })
       // ref?.child("Lists").child(dataget).child("Items").removeAllObservers()
       // ref?.removeAllObservers()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source
    @objc func mamamia(recognizer: UITapGestureRecognizer){
        
            if recognizer.state == UIGestureRecognizerState.ended {
                let tapLocation = recognizer.location(in: self.tableView)
                if let tapIndexPath = self.tableView.indexPathForRow(at: tapLocation) {
                    if let tappedCell = self.tableView.cellForRow(at: tapIndexPath) as? UITableViewCell {
                        if tapIndexPath.row != basiclist?.items.count{
                            let alert = UIAlertController(title: "title", message: "enter a new title", preferredStyle: .alert)
                            alert.addTextField { (textField) in
                                textField.text = ""
                            }
                            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
                                let textField = alert!.textFields![0]
                                self.basiclist?.items[tapIndexPath.row].value = textField.text ?? ""
                                DispatchQueue.main.async {
                                    self.tableView.reloadData()
                                    
                                    //for testing purposes. Delete once a proper button has been added
                                    //post to firebase
                                    //                    self.ref?.child("Lists").childByAutoId().setValue(self.basiclist.items)
                                }
                            }))
                            self.present(alert, animated: true, completion: nil)
                            DispatchQueue.main.async {
                                self.tableView.reloadData()
                                
                                //for testing purposes. Delete once a proper button has been added
                                //post to firebase
                                //                self.ref?.child("Lists").childByAutoId().setValue(self.basiclist.items)
                            }
                        }
                        
                    }
                }
            }
        
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return basiclist!.items.count+1
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "gamer", for: indexPath)
        
        if indexPath.row != basiclist?.items.count{
                cell.textLabel?.text=basiclist?.items[indexPath.row].value
       
        //cell.selectionStyle = UITableViewCellSelectionStyle.none
        if basiclist?.items[indexPath.row].done == false{
            cell.textLabel?.text?.append("❎")
        }
        else{
            cell.textLabel?.text?.append("✅")
            
        }
     cell.isEditing=true
     cell.showsReorderControl=true
        }
        else{
            cell.textLabel?.text = "add new"
            cell.isEditing=false
           cell.showsReorderControl=false
        }

        return cell
    }
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        if indexPath.row != (basiclist?.items.count)!{
            return true}
        return false
    }
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let  buffer = basiclist?.items[destinationIndexPath.row]
        basiclist?.items[destinationIndexPath.row] = (basiclist?.items[sourceIndexPath.row])!
        basiclist?.items[sourceIndexPath.row]=buffer!
        
        
        
    }
    override func tableView(_ tableView: UITableView, targetIndexPathForMoveFromRowAt sourceIndexPath: IndexPath, toProposedIndexPath proposedDestinationIndexPath: IndexPath) -> IndexPath {
        if proposedDestinationIndexPath.row == (basiclist?.items.count)! {
            return IndexPath(row: proposedDestinationIndexPath.row - 1, section: proposedDestinationIndexPath.section)
        } else {
            return proposedDestinationIndexPath
        }
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if indexPath.row != basiclist?.items.count{
            basiclist?.items.remove(at: indexPath.row)}
        DispatchQueue.main.async {
            self.tableView.reloadData()
            //for testing purposes. Delete once a proper button has been added
            //post to firebase
            //                    self.ref?.child("Lists").childByAutoId().setValue(self.basiclist.items)
        }
    }
     override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (indexPath.row != basiclist?.items.count && (basiclist?.items[indexPath.row].type)! == true) {
            print("a")
            let board = UIStoryboard(name: "newlist", bundle: self.nibBundle)
            let controller = board.instantiateInitialViewController() as! neweditController
            controller.dataget=String((basiclist?.items[indexPath.row].stuff)!)
            ref?.child("Lists").child(dataget).child("Items").removeAllObservers()
            basiclist = newlist(newitems: [newitem](), newtitle: "", newcreated: Date.init())
            self.present(controller,animated: true)
            self.viewDidLoad()
            
           // print(String((basiclist?.items[indexPath.row].value.split(separator: "⍰")[1])!))
        }
        
        else if indexPath.row != basiclist?.items.count{
            basiclist?.items[indexPath.row].done.toggle()
        }
        else {
            let alert = UIAlertController(title: "add item", message: "", preferredStyle: .alert)
            alert.addTextField { (textField) in
                textField.text = ""
            }
            alert.addAction(UIAlertAction(title: "add item", style: .default, handler: { [weak alert] (_) in
                self.basiclist?.items.append(newitem(newdone: false, newtype: false, newvalue: alert?.textFields?[0].text ?? "" ))
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    //for testing purposes. Delete once a proper button has been added
                    //post to firebase
                    //                    self.ref?.child("Lists").childByAutoId().setValue(self.basiclist.items)
                }
            }))
            alert.addAction(UIAlertAction(title: "add list", style: .default, handler: { [weak alert] (_) in
                var lamer = "List_1"
                var b = newitem(newdone: false, newtype: true, newvalue: alert?.textFields?[0].text ?? "uuu")
                var rev = Database.database().reference()
                
                rev.observe(.childAdded, with: {(snashot) in
                    print(snashot.children.allObjects)
                    print("but is it real")
                    print(snashot.hasChild(lamer))
                    print("But is it really real")
                    print(snashot.hasChild(lamer))
                    print("what even is this madness")
                    print(lamer)
                    var i = 1
                    while (snashot.childSnapshot(forPath: lamer).exists()){
                        print(i)
                        i = i + 1
                        
                        lamer = String(lamer.dropLast())
                        lamer.append(String(i))
                        b.stuff=lamer
                    }
                    
                    
                    
                   
                    
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                })
                b.stuff=lamer
                self.basiclist?.items.append(b)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }))
            self.present(alert, animated:false)
            DispatchQueue.main.async {
                self.tableView.reloadData()
                //for testing purposes. Delete once a proper button has been added
                //post to firebase
                //                    self.ref?.child("Lists").childByAutoId().setValue(self.basiclist.items)
            }
            
        }
        DispatchQueue.main.async {
            self.tableView.reloadData()
            //for testing purposes. Delete once a proper button has been added
            //post to firebase
            //                    self.ref?.child("Lists").childByAutoId().setValue(self.basiclist.items)
        }
        
    }
    override func becomeFirstResponder() -> Bool {
        return true
    }
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        
        if motion == .motionShake {
            ref?.child("Lists").child(dataget).child("Items").removeAllObservers()
            ref?.removeAllObservers()
            var snapshot = ref!.child("Lists").child(dataget).child("Items")
            var gamer = "Item_0"
            for i  in 0...basiclist!.items.count-1{
                gamer = String(gamer.dropLast())
                gamer.append(String(i+1))
                snapshot.child(gamer).child("Name").setValue(basiclist?.items[i].value)
                if basiclist?.items[i].type == false{
                    let poop = (basiclist?.items[i].done)! ? 1 : 0
                    print(poop)
                //snapshot.child(gamer).child("Done").setValue(result)
                    var v = "%" + String(poop) + "%" + (basiclist?.items[i].stuff.substring(from: (basiclist?.items[i].stuff.index((basiclist?.items[i].stuff.startIndex)!, offsetBy: 3))!))!
                    snapshot.child(gamer).child("Value").setValue(v)}
                else {snapshot.child(gamer).child("Value").setValue(basiclist?.items[i].stuff)}
                let soop = (basiclist?.items[i].type)! ? 1 : 0
                snapshot.child(gamer).child("Type").setValue(soop)
                let formatteddate = DateFormatter()
                formatteddate.dateStyle = .long
                formatteddate.timeStyle = .long
                snapshot.child(gamer).child("Last_Edited").setValue(formatteddate.string(from: Date.init()))
              
            }
           self.dismiss(animated: true, completion: nil)
              //basiclist = newlist(newitems: [newitem](), newtitle: "", newcreated: Date.init())
        }
    }
 
  


    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
