//
//  tableViewController.swift
//  listedit
//
//  Created by Alexander Romine (student LM) on 2/3/19.
//  Copyright © 2019 Alexander Romine (student LM). All rights reserved.
//

import UIKit

class editViewController: UITableViewController, passsbackitem {
    
    
    //@IBOutlet var tableview: UITableView!
   
    @IBOutlet var tableview: UITableView!
    let basicarray = [item(newcontent: "s", newdone: false, newsubitems: [item]()), item(newcontent: "b", newdone: false, newsubitems: [item]())]
    var basicitem : item = item(newcontent: "", newdone: true, newsubitems: [item]())
    var basiclist = list(newitems: [item](), newtitle: "", newcreated: Date.init())
    func passbackitem(value: item) {
    }
    func passbackname(value: String) {
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        basicitem = item(newcontent: "i love fortnite and video games", newdone: false, newsubitems: basicarray)
        let x = [basicitem]
         basiclist = list(newitems: x, newtitle: "basic list", newcreated: Date.init())
        // Do any additional setup after loading the view.
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0{
            let alert = UIAlertController(title: "title", message: "enter a new title", preferredStyle: .alert)
            alert.addTextField { (textField) in
                textField.text = ""
            }
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
                let textField = alert!.textFields![0]
                self.basiclist.title = textField.text!
            }))
            self.present(alert, animated: true, completion: nil)
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        else if indexPath.row == basiclist.items.count+1{
            let alert = UIAlertController(title: "new item", message: "", preferredStyle: .alert)
            alert.addTextField { (textField) in
                textField.text = "item name"
            }
            alert.addAction(UIAlertAction(title: "add", style: .default, handler: { [weak alert] (_) in
                self.basiclist.items.append(item(newcontent: (alert?.textFields![0].text)!, newdone: false, newsubitems: [item]()))
                }
            ))
            self.present(alert, animated: true, completion: nil)
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
      /*  else{
            let alert = UIAlertController(title: "item", message: "", preferredStyle: .alert)
            alert.addTextField { (textField) in
                textField.text = self.basiclist.items[indexPath.row-1].content
            }
            alert.addAction(UIAlertAction(title: "done", style: .default, handler: { [weak alert] (_) in
                let textField = alert!.textFields![0]
                self.basiclist.items[indexPath.row-1].content = textField.text!
            }))
            
            self.present(alert, animated: true, completion: nil)
            tableView.reloadData()
        }
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }*/
        else{
            let controller = itemViewController()
            controller.itemtoedit = basiclist.items[indexPath.row-1]
            self.present(controller, animated: true, completion: nil)

        }
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return basiclist.items.count+2
        
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: "cell")
        if indexPath.row == 0{
            cell?.textLabel?.text = String("Title:\(basiclist.title)")
        }
        else if indexPath.row == basiclist.items.count+1{
            cell?.textLabel?.text = "add more"
        }
        else{
            cell?.textLabel?.text = basiclist.items[indexPath.row-1].content
            if basiclist.items[indexPath.row-1].done == true{
                cell?.textLabel?.text?.append("[✓]")
                cell?.setNeedsDisplay()
            }
            else{
                cell?.textLabel?.text?.append("[X]")
                cell?.setNeedsDisplay()
            }
        }
        
        return cell!
    }
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]?
    {
        // 1
        if indexPath.row != 0 && indexPath.row != basiclist.items.count+1{
            let doneaction = UITableViewRowAction(style: UITableViewRowAction.Style.default, title: "done" , handler: { (action:UITableViewRowAction, indexPath: IndexPath) -> Void in
                self.basiclist.items[indexPath.row-1].done = true
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                
            })
            // 3
            let notdoneaction = UITableViewRowAction(style: UITableViewRowAction.Style.default, title: "not done" , handler: { (action:UITableViewRowAction, indexPath:IndexPath) -> Void in
                self.basiclist.items[indexPath.row-1].done = false
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            })
            // 5
            return [doneaction,notdoneaction]}
        return [UITableViewRowAction]()
    }
   // override func table
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
