//
//  ViewController.swift
//  Scribbit
//
//  Created by Oron Barash (student LM) on 1/3/19.
//  Copyright © 2019 Oron Barash (student LM). All rights reserved.
//

import UIKit
import Firebase


class ViewController: UIViewController {
    @IBOutlet weak var signup: UIButton!
    @IBOutlet var background: UIView!
    @IBOutlet weak var login: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        background.backgroundColor = colorChoices.bgColor
        
        signup.backgroundColor = colorChoices.fgColor
        signup.titleLabel?.textColor = colorChoices.bgColor
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

