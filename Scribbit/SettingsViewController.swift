//
//  SettingsViewController.swift
//  Scribbit
//
//  Created by Isaac Wetherbee (student LM) on 3/6/19.
//  Copyright © 2019 Oron Barash (student LM). All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var ModeLable: UILabel!
    
    @IBAction func SwitchTapped(_ sender: UISwitch) {
        colorChoices.currentTheme = !colorChoices.currentTheme
        view.backgroundColor = colorChoices.bgColor
        ModeLable.textColor = colorChoices.fgColor
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        ModeLable.textColor = colorChoices.fgColor
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
}
