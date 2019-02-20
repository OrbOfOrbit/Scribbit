//
//  itemViewController.swift
//  listedit
//
//  Created by Alexander Romine (student LM) on 2/8/19.
//  Copyright © 2019 Alexander Romine (student LM). All rights reserved.
//

import UIKit

class itemViewController: UIViewController, UITableViewDataSource,UITableViewDelegate {
    var itemtoedit = item(newcontent: "", newdone: false, newsubitems: [item]())
    var myTableView:UITableView!
    var titletext:UITextField!
    var exitbutton:UIButton!
    var callback : ((item)->())?
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemtoedit.subitems.count+1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = myTableView.dequeueReusableCell(withIdentifier: "cell")
        if indexPath.row == itemtoedit.subitems.count{
        cell?.textLabel?.text = "add more"
        }
        else {
            cell?.textLabel?.text = itemtoedit.subitems[indexPath.row].content
            if itemtoedit.subitems[indexPath.row].done == true{
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
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == itemtoedit.subitems.count{
            let alert = UIAlertController(title: "new item", message: "", preferredStyle: .alert)
            alert.addTextField { (textField) in
                textField.text = "item name"
            }
            alert.addAction(UIAlertAction(title: "add", style: .default, handler: { [weak alert] (_) in
                self.itemtoedit.subitems.append(item(newcontent: (alert?.textFields![0].text)!, newdone: false, newsubitems: [item]()))
                DispatchQueue.main.async {
                    tableView.reloadData()
                }
                }
            ))
            self.present(alert, animated: true, completion: nil)
            
        }
        else{
            let alert = UIAlertController(title: "item name change", message: "", preferredStyle: .alert)
            alert.addTextField { (textField) in
                textField.text = self.itemtoedit.subitems[indexPath.row].content
            }
            alert.addAction(UIAlertAction(title: "add", style: .default, handler: { [weak alert] (_) in
                self.itemtoedit.subitems[indexPath.row].content = (alert?.textFields![0].text)!
                DispatchQueue.main.async {
                    tableView.reloadData()
                }
                }
            ))
              self.present(alert, animated: true, completion: nil)
        }
    }
    
    
  
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        let barHeight: CGFloat = UIApplication.shared.statusBarFrame.size.height
        let displayWidth: CGFloat = self.view.frame.width
        let displayHeight: CGFloat = self.view.frame.height-8
        myTableView = UITableView(frame: CGRect(x: 0, y: barHeight+16, width: displayWidth, height: displayHeight - barHeight))
        myTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        myTableView.dataSource = self
        myTableView.delegate = self
        self.view.addSubview(myTableView)
        titletext = UITextField(frame: CGRect(x: 0, y: barHeight, width: displayWidth-20, height: 16) )
        titletext.text = itemtoedit.content
        self.view.addSubview(titletext)
        exitbutton = UIButton(type: .system)
        exitbutton.setTitle("exit", for: .normal)
        exitbutton.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
        exitbutton.frame = CGRect(x: self.view.frame.width-20, y: barHeight-8, width:20, height: 16)
        exitbutton.backgroundColor = .red
        self.view.addSubview(exitbutton)
        // Do any additional setup after loading the view.
    }

   
     @objc func buttonClicked(sender : UIButton){
        callback!(item(newcontent: titletext.text ?? itemtoedit.content, newdone: itemtoedit.done, newsubitems: itemtoedit.subitems))
        self.dismiss(animated: true, completion: nil)
    }
   func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]?
    {
        // 1
        if indexPath.row != itemtoedit.subitems.count+1{
            let doneaction = UITableViewRowAction(style: .normal, title: "done" , handler: { (action:UITableViewRowAction, indexPath: IndexPath) -> Void in
                self.itemtoedit.subitems[indexPath.row].done = true
                DispatchQueue.main.async {
                    self.myTableView.reloadData()
                }
                
            })
            // 3
            let notdoneaction = UITableViewRowAction(style: .normal, title: "not done" , handler: { (action:UITableViewRowAction, indexPath:IndexPath) -> Void in
                self.itemtoedit.subitems[indexPath.row].done = false
                DispatchQueue.main.async {
                    self.myTableView.reloadData()
                }
            })
            // 5
            return [doneaction,notdoneaction]}
        return [UITableViewRowAction]()
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
