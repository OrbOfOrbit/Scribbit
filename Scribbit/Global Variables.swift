//
//  Global Variables.swift
//  FirebaseAuth
//
//  Created by Justin Cannan (student LM) on 1/11/19.
//
// Class that stores color variables, making it easier to switch between them as needed

import Foundation
import UIKit

// Global Variable Information:
//  Here is where you create global variables. Just Use the syntax as seen below (public static var)
// and set up a get function (or a set, if you feel like it). When accessing the global variables in
// your code, simply use YourClass.YourVariable. Feel free to create new classes for new types of 
// variable, just keep everything organized.

//Color Choices Info:
//  Whenever you create *any* item that has a color, aside from those in the toolbar, make sure that its
// color is coded manually to either the green background/text (bgColor) or the white (fgColor) within the
// view controller (not the storyboard!). 

class colorChoices{
  
  //  bgColor: Returns a light green color. Should be used for the background and text. 
  public static var bgColor :UIColor{
        get{
            return UIColor.init(red: 115/255, green: 250/255, blue: 145/255, alpha: 100)
            
        }
    }
    
  //  fgColor: Returns white. Should be used in the backgrounds of buttons or other items (to contrast from the green
  // (background)
    public static var fgColor: UIColor{
        get{
            return UIColor.white
        }
    }
    
}
    

