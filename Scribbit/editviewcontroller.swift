import UIKit
import Firebase
import FirebaseDatabase
import FirebaseStorage


//      note to self: instead of going through the immense trouble of merging this code, just copy over the list
//  encoding code and the code that uploads the list to firebase to the newer version. It's a better idea trust me.


class editViewController: UITableViewController {
    
    var ref: DatabaseReference?
    let jsonEncoder = JSONEncoder()
    
    
    //@IBOutlet var tableview: UITableView!
    
    @IBOutlet var tableview: UITableView!
    let basicarray = [item(newcontent: "s", newdone: false, newsubitems: [item]()), item(newcontent: "b", newdone: false, newsubitems: [item]())]
    var basicitem : item = item(newcontent: "", newdone: true, newsubitems: [item]())
    var basiclist = list(newitems: [item](), newtitle: "", newcreated: Date.init())
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        
        //set database refrence
        ref = Database.database().reference()
        
        // Create a root reference
       
        //test encoding code
        //creates a test list for testing encoding
        let testList = list(newitems: [item(newcontent: "gorgodo", newdone: false, newsubitems: [item(newcontent: "jamba", newdone: false, newsubitems: [])])], newtitle: "gorgon", newcreated: Date.init())
       //prints the bite count of the encoted list
        print(encode(testList))
        //prints a string containing the encoded data
        if let dataString = String(data: encode(testList), encoding: String.Encoding.utf8){
            print(dataString)
            
            //write file to directory
            //create directory
            var homePath = NSHomeDirectory()
            homePath.append("/jsonFile.txt")
            print(homePath)
            let pathURL = URL(fileURLWithPath: homePath)
            
            //save to directory
            do {
                try encode(testList).write(to: pathURL)
                
            } catch {
                print("Couldn't write file")
            }
            
            
        }
        //writes an object
        
        
        
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
//                    let jsonData = try jsonEncoder.encode(basiclist)
                    self.ref?.child("Lists").childByAutoId().setValue(self.basiclist.items)
                }
            }))
            self.present(alert, animated: true, completion: nil)
            DispatchQueue.main.async {
                self.tableView.reloadData()
                
                //for testing purposes. Delete once a proper button has been added
                //post to firebase
               
                //create refrence to new list
                let listRefrence = self.ref?.child("Lists").childByAutoId()
                
                    //set values of date and contributors
                    listRefrence?.child("Contributors").setValue("replace with var")
                    listRefrence?.child("Date Created").setValue("replace with var")
                    listRefrence?.child("Last Edited").setValue(self.basiclist.created)
                    listRefrence?.child("Name").setValue(self.basiclist.title)
                
                    //create refrence to specific item item
                    let itemRefrence = listRefrence?.child("Items").childByAutoId()
                
                        //use item refrence to create item
                
                            //for loop will sort through the various items
          //                for item in self.basiclist.items{
                            itemRefrence?.child("Last_Edited").setValue("replace with var")
                            itemRefrence?.child("Name").setValue("replace with var")
                            itemRefrence?.child("Type").setValue("replace with var")
                            itemRefrence?.child("Value").setValue("replace with var")
//                }
                
                
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
                    self.ref?.child("Lists").childByAutoId().setValue(self.basiclist.items)
                }
                }
            ))
            self.present(alert, animated: true, completion: nil)
            
            
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
                //for testing purposes. Delete once a proper button has been added
                //post to firebase
                self.ref?.child("Lists").childByAutoId().setValue(self.basiclist.items)
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
                    self.ref?.child("Lists").childByAutoId().setValue(self.basiclist.items)
                }
            }
            
        }
        DispatchQueue.main.async {
            self.tableView.reloadData()
            //for testing purposes. Delete once a proper button has been added
            //post to firebase
            self.ref?.child("Lists").childByAutoId().setValue(self.basiclist.items)
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
                    self.ref?.child("Lists").childByAutoId().setValue(self.basiclist.items)
                }
                
            })
            // 3
            let notdoneaction = UITableViewRowAction(style: .normal, title: "not done" , handler: { (action:UITableViewRowAction, indexPath:IndexPath) -> Void in
                self.basiclist.items[indexPath.row-1].done = false
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    //for testing purposes. Delete once a proper button has been added
                    //post to firebase
                    self.ref?.child("Lists").childByAutoId().setValue(self.basiclist.items)
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
    
    func encode(_ list:list)->Data{
        
        var jsonData = Data()
        
        do{
            jsonData = try jsonEncoder.encode(list)
        }catch{
            print("oopsie woopsie")
        }
        
        return jsonData
    }
    
    
    
    
}
