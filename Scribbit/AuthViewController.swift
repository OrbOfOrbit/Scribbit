//
//  AuthViewController.swift
//  Scribbit
//
//  Created by Justin Cannan (student LM) on 2/7/19.
//  Copyright © 2019 Oron Barash (student LM). All rights reserved.
//
import UIKit
import FirebaseAuth

class AuthViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
    //    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    //        // Get the new view controller using segue.destinationViewController.
    //        // Pass the selected object to the new view controller.
    //
    //        let storyboard = UIStoryboard(name: "Main", bundle: nil)
    //        let vc = storyboard.instantiateViewController(withIdentifier: "ListViewController") as UIViewController
    //        present(vc, animated: true, completion: nil)
    //    }
    //this is the autologin feature, do not touch
    override func viewDidAppear(_ animated: Bool) {
        if let _ = Auth.auth().currentUser{
            let board = UIStoryboard(name: "HomeScreenStoryboard", bundle: self.nibBundle)
            let controller = board.instantiateInitialViewController() as! HomeScreenViewController
            self.present(controller, animated: false)
        }
    }
    
}
