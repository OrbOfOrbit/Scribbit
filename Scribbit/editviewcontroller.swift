
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
    var basiclist:newlist?
    var listdate = [String]()
    var dataget="List_1"
    override func viewDidLoad() {
        tableview.backgroundColor = .green
        view.backgroundColor = .green
        tableView.delegate = self
        tableView.dataSource = self
        let longrecon = UILongPressGestureRecognizer(target: self, action: #selector(longtap))
        tableview.addGestureRecognizer(longrecon)
        super.viewDidLoad()
        basiclist = newlist(newitems: [newitem](), newtitle: "", newcreated: Date.init())
        tableview.isEditing=true
        tableview.allowsSelectionDuringEditing = true
        ref = Database.database().reference()
        ref?.child("Lists").child(dataget).child("Items").observe(.value, with: {(snapshot) in
          //  self.basiclist?.items = [newitem]()
            var stringiterator = "Item_1"
            var i = 1
            while (snapshot.childSnapshot(forPath: stringiterator).exists()){
                
                var isdone:Bool
                if (snapshot.childSnapshot(forPath: stringiterator).childSnapshot(forPath: "Value").value as? String)!.first == "%"{
                    
                    let  p = (snapshot.childSnapshot(forPath: stringiterator).childSnapshot(forPath: "Value").value as? String)!.split(separator: "%")[0]
                    let b = Int(String(p))
                    isdone = (b)! == 1}
                else {isdone = false}
                
                let additem = newitem(newdone: isdone, newtype: (snapshot.childSnapshot(forPath: stringiterator).childSnapshot(forPath: "Type").value as? Bool)!, newvalue: (snapshot.childSnapshot(forPath: stringiterator).childSnapshot(forPath: "Name").value as? String)!)
                additem.stuff = (snapshot.childSnapshot(forPath: stringiterator).childSnapshot(forPath: "Value").value as? String)!
                self.basiclist?.items.append(additem)
                
                
                
                
                i = i + 1
                
                stringiterator = String(stringiterator.dropLast())
                stringiterator.append(String(i))
                DispatchQueue.main.async {
                    self.tableView.reloadData()
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
    @objc func longtap(recognizer: UITapGestureRecognizer){
        
        if recognizer.state == UIGestureRecognizerState.ended {
            let tapLocation = recognizer.location(in: self.tableView)
            if let tapIndexPath = self.tableView.indexPathForRow(at: tapLocation) {
                if (self.tableView.cellForRow(at: tapIndexPath)) != nil {
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
            cell.backgroundColor = UIColor.green
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
            ref?.child("Lists").child(dataget).child("Items").removeAllObservers()
            ref?.removeAllObservers()
            let snapshot = ref!.child("Lists").child(dataget).child("Items")
            var savestringiterator = "Item_0"
            if (basiclist?.items.count==0){
                self.dismiss(animated: true, completion: nil)
                return
            }
            for i  in 0...basiclist!.items.count-1{
                savestringiterator = String(savestringiterator.dropLast())
                savestringiterator.append(String(i+1))
                snapshot.child(savestringiterator).child("Name").setValue(basiclist?.items[i].value)
                if basiclist?.items[i].type == false{
                    let doneasint = (basiclist?.items[i].done)! ? 1 : 0
                    //snapshot.child(gamer).child("Done").setValue(result)
                    let v = "%" + String(doneasint) + "%" + (basiclist?.items[i].stuff.substring(from: (basiclist?.items[i].stuff.index((basiclist?.items[i].stuff.startIndex)!, offsetBy: 3))!))!
                    snapshot.child(savestringiterator).child("Value").setValue(v)}
                else {snapshot.child(savestringiterator).child("Value").setValue(basiclist?.items[i].stuff)}
                let soop = (basiclist?.items[i].type)! ? 1 : 0
                snapshot.child(savestringiterator).child("Type").setValue(soop)
                let formatteddate = DateFormatter()
                formatteddate.dateStyle = .long
                formatteddate.timeStyle = .long
                snapshot.child(savestringiterator).child("Last_Edited").setValue(formatteddate.string(from: Date.init()))
                
            }
            let board = UIStoryboard(name: "list", bundle: self.nibBundle)
            let controller = board.instantiateInitialViewController() as! neweditController
            controller.dataget=String((basiclist?.items[indexPath.row].stuff)!)
            ref?.child("Lists").child(dataget).child("Items").removeAllObservers()
            basiclist = newlist(newitems: [newitem](), newtitle: "", newcreated: Date.init())
            self.present(controller,animated: true)
            self.viewDidLoad()
            
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
                }
            }))
            alert.addAction(UIAlertAction(title: "add list", style: .default, handler: { [weak alert] (_) in
                var editstringiterator = "List_1"
                let b = newitem(newdone: false, newtype: true, newvalue: alert?.textFields?[0].text ?? "uuu")
                let rev = Database.database().reference()
                
                rev.observe(.childAdded, with: {(snashot) in
                    var i = 1
                    while (snashot.childSnapshot(forPath: editstringiterator).exists()){
                        i = i + 1
                        
                        editstringiterator = String(editstringiterator.dropLast())
                        editstringiterator.append(String(i))
                        b.stuff=editstringiterator
                    }
                    
                    
                    
                    
                    
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                })
                rev.child("Lists").observeSingleEvent(of:.value, with: {(snapshot) in
                    let l = snapshot.childSnapshot(forPath:"Total_Lists_Created").value as! Int + 1
                    rev.child("Lists").child("Total_Lists_Created").setValue(l)
                    
                })
                b.stuff=editstringiterator
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
            let snapshot = ref!.child("Lists").child(dataget).child("Items")
            var savestringiterator = "Item_0"
            if (basiclist?.items.count==0){
                self.dismiss(animated: true, completion: nil)
                return
            }
            for i  in 0...basiclist!.items.count-1{
                savestringiterator = String(savestringiterator.dropLast())
                savestringiterator.append(String(i+1))
                snapshot.child(savestringiterator).child("Name").setValue(basiclist?.items[i].value)
                if basiclist?.items[i].type == false{
                    let doneasint = (basiclist?.items[i].done)! ? 1 : 0
                    //snapshot.child(gamer).child("Done").setValue(result)
                    let v = "%" + String(doneasint) + "%" + (basiclist?.items[i].stuff.substring(from: (basiclist?.items[i].stuff.index((basiclist?.items[i].stuff.startIndex)!, offsetBy: 3))!))!
                    snapshot.child(savestringiterator).child("Value").setValue(v)}
                else {snapshot.child(savestringiterator).child("Value").setValue(basiclist?.items[i].stuff)}
                let soop = (basiclist?.items[i].type)! ? 1 : 0
                snapshot.child(savestringiterator).child("Type").setValue(soop)
                let formatteddate = DateFormatter()
                formatteddate.dateStyle = .long
                formatteddate.timeStyle = .long
                snapshot.child(savestringiterator).child("Last_Edited").setValue(formatteddate.string(from: Date.init()))
                
            }
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    
}
