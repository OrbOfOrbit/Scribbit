//
//  subfileTableViewController.swift
//  Scribbit
//
//  Created by Alexander Romine (student LM) on 3/21/19.
//  Copyright © 2019 Oron Barash (student LM). All rights reserved.
//

import UIKit
import FirebaseDatabase
class subfileTableViewController:  UIViewController, UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cbell = myTableView.dequeueReusableCell(withIdentifier: "bcell")
        cbell?.textLabel?.text = "gggggg"
        return cbell!
    }
    
    var dataget:String = ""
    var myTableView:UITableView!
    var titletext:UITextField!
    var exitbutton:UIButton!
    var ref:DatabaseReference?
    var basiclist:newlist?
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        basiclist = newlist(newitems: [newitem](), newtitle: "", newcreated: Date.init())
        let barHeight: CGFloat = UIApplication.shared.statusBarFrame.size.height
        let displayWidth: CGFloat = self.view.frame.width
        let displayHeight: CGFloat = self.view.frame.height-8
        myTableView = UITableView(frame: CGRect(x: 0, y: barHeight+16, width: displayWidth, height: displayHeight - barHeight))
        myTableView.register(UITableViewCell.self, forCellReuseIdentifier: "bcell")
        myTableView.dataSource = self
        myTableView.delegate = self
        self.view.addSubview(myTableView)
        titletext = UITextField(frame: CGRect(x: 0, y: barHeight, width: displayWidth-20, height: 16) )
       // titletext.text = itemtoedit.content
        self.view.addSubview(titletext)
        exitbutton = UIButton(type: .system)
        exitbutton.setTitle("exit", for: .normal)
        exitbutton.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
        exitbutton.frame = CGRect(x: self.view.frame.width-20, y: barHeight-8, width:20, height: 16)
        exitbutton.backgroundColor = .red
        self.view.addSubview(exitbutton)
        ref = Database.database().reference()
        print(dataget)
        ref?.child("Lists").child("List_1").child("Items").observe(.value, with: {(snapshot) in
            var gamer = "Item_1"
            var i = 1
            while (snapshot.childSnapshot(forPath: gamer).exists()){
                print("a")
                
                if snapshot.childSnapshot(forPath: gamer).childSnapshot(forPath: "Type").value as! Int == 0{
                    
                    let additem = newitem(newdone: (snapshot.childSnapshot(forPath: gamer).childSnapshot(forPath: "Done").value as? Bool)!, newtype: true, newvalue: (snapshot.childSnapshot(forPath: gamer).childSnapshot(forPath: "Name").value as? String)!)
                    self.basiclist?.items.append(additem)
                    
                }
                else if snapshot.childSnapshot(forPath: gamer).childSnapshot(forPath: "Type").value as! Int == 1{
                    let additem = newitem(newdone: (snapshot.childSnapshot(forPath: gamer).childSnapshot(forPath: "Done").value as? Bool)!, newtype: false, newvalue: (snapshot.childSnapshot(forPath: gamer).childSnapshot(forPath: "Name").value as? String)! + "⍰" + (snapshot.childSnapshot(forPath: gamer).childSnapshot(forPath: "Value").value as? String)!)
                    self.basiclist?.items.append(additem)
                    
                    
                }
                
                i = i + 1
                
                gamer = String(gamer.dropLast())
                gamer.append(String(i))
                print(gamer)
                print(self.basiclist?.items.count)
                DispatchQueue.main.async {
                    self.myTableView.reloadData()
                    
                    //for testing purposes. Delete once a proper button has been added
                    //post to firebase
                    //                self.ref?.child("Lists").childByAutoId().setValue(self.basiclist.items)
                }
            }
            
            
        })
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    @objc func buttonClicked(sender : UIButton){
        //callback!()
        self.dismiss(animated: true, completion: nil)
    }

    // MARK: - Table view data source

    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 5
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

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
