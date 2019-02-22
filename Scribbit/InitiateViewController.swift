//
//  InitiateViewController.swift
//  Scribbit
//
//  Created by Alexander Romine (student LM) on 2/21/19.
//  Copyright © 2019 Oron Barash (student LM). All rights reserved.
//

import UIKit

class InitiateViewController: UIViewController {

    @IBOutlet weak var textfield: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.destination is editViewController
        {
            let vc = segue.destination as? editViewController
            vc?.basiclist = list(newitems: [item](), newtitle: textfield.text ?? "new list", newcreated: Date.init())
        }
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
