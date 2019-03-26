import UIKit
import Firebase
import FirebaseDatabase

class editViewController: UITableViewController {
    
    var ref: DatabaseReference?
    
    //@IBOutlet var tableview: UITableView!
    
   
    @IBOutlet var tableview: UITableView!
    let basicarray = [item(newcontent: "s", newdone: false, newsubitems: [item]()), item(newcontent: "b", newdone: false, newsubitems: [item]())]
    var basicitem : item = item(newcontent: "", newdone: true, newsubitems: [item]())
    var basiclist = list(newitems: [item](), newtitle: "", newcreated: Date.init())
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //set database refrence
        ref = Database.database().reference()
        
        
        
        //basiclist = list(newitems: x, newtitle: "basic list", newcreated: Date.init())
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
        else if indexPath.row == basiclist.items.count+1{
            let alert = UIAlertController(title: "new item", message: "", preferredStyle: .alert)
            alert.addTextField { (textField) in
                textField.text = "item name"
            }
            alert.addAction(UIAlertAction(title: "add", style: .default, handler: { [weak alert] (_) in
                self.basiclist.items.append(item(newcontent: (alert?.textFields![0].text)!, newdone: false, newsubitems: [item]()))
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    //for testing purposes. Delete once a proper button has been added
                    //post to firebase
//                    self.ref?.child("Lists").childByAutoId().setValue(self.basiclist.items)
                }
                }
            ))
            self.present(alert, animated: true, completion: nil)
            
            
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
                //for testing purposes. Delete once a proper button has been added
                //post to firebase
//                self.ref?.child("Lists").childByAutoId().setValue(self.basiclist.items)
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
            controller.callback = { result in
                self.basiclist.items[indexPath.row-1] = result
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    //for testing purposes. Delete once a proper button has been added
                    //post to firebase
//                    self.ref?.child("Lists").childByAutoId().setValue(self.basiclist.items)
                }
            }
            
        }
        DispatchQueue.main.async {
            self.tableView.reloadData()
            //for testing purposes. Delete once a proper button has been added
            //post to firebase
//            self.ref?.child("Lists").childByAutoId().setValue(self.basiclist.items)
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
                cell?.textLabel?.text?.append("✅")
                cell?.setNeedsDisplay()
            }
            else{
                cell?.textLabel?.text?.append("❌")
                cell?.setNeedsDisplay()
            }
        }
        
        return cell!
    }
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]?
    {
        // 1
        if indexPath.row != 0 && indexPath.row != basiclist.items.count+1{
            let doneaction = UITableViewRowAction(style: .normal, title: "done" , handler: { (action:UITableViewRowAction, indexPath: IndexPath) -> Void in
                self.basiclist.items[indexPath.row-1].done = true
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    //for testing purposes. Delete once a proper button has been added
                    //post to firebase
//                    self.ref?.child("Lists").childByAutoId().setValue(self.basiclist.items)
                }
                
            })
            // 3
            let notdoneaction = UITableViewRowAction(style: .normal, title: "not done" , handler: { (action:UITableViewRowAction, indexPath:IndexPath) -> Void in
                self.basiclist.items[indexPath.row-1].done = false
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    //for testing purposes. Delete once a proper button has been added
                    //post to firebase
//                    self.ref?.child("Lists").childByAutoId().setValue(self.basiclist.items)
                }
            })
            let deletethis = UITableViewRowAction(style: .normal, title: "delete this" , handler: { (action:UITableViewRowAction, indexPath:IndexPath) -> Void in
                self.basiclist.items.remove(at: indexPath.row-1)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    //for testing purposes. Delete once a proper button has been added
                    //post to firebase
                    //                    self.ref?.child("Lists").childByAutoId().setValue(self.basiclist.items)
                }
            })
            // 5
            return [doneaction,notdoneaction,deletethis]}
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
