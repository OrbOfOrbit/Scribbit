//
//  ViewController.swift
//  Scribbit
//
//  Created by Isaac Wetherbee (student LM) on 2/27/19.
//  Copyright © 2019 Oron Barash (student LM). All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    
    
    
var isvis: Bool!
    @IBOutlet weak var Viewofscreen: UIView!
    @IBAction func MenuButtontapped(_ sender: UIBarButtonItem) {
        if(!isvis){
            UIView.animate(withDuration: 0.5) {
                self.Viewofscreen.center.x += 125
            }
            isvis=true
        }else{
            UIView.animate(withDuration: 0.5) {
                self.Viewofscreen.center.x -= 125
            }
            isvis=false
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        isvis = false
        Viewofscreen.backgroundColor = colorChoices.bgColor
        
        
        
        colorChoices.currentTheme = !colorChoices.currentTheme
        view.backgroundColor = colorChoices.bgColor
        colorChoices.currentTheme = !colorChoices.currentTheme
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
