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
        }
        return cell!
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == itemtoedit.subitems.count{
            
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
        self.dismiss(animated: true, completion: nil)
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
