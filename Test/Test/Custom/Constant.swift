//
//  Constant.swift
//  Contact App
//
//  Created by Hexagon on 04/05/20.
//  Copyright © 2020 Hexagon. All rights reserved.
//

import Foundation
import UIKit

struct  Constant {
    
    static let MSG_EMAIL_VALIDATION = "Please enter a valid email"
    static let MSG_PHONE_VALIDATION = "Enter phone no"
    static let MSG_REFERAL_CODE_VALIDATION = "Enter refferal no"
    static let MSG_CHECK = "Required all field"
    
    static let ALERT_BUTTON_OK = "OK"
    static let ALERT_BUTTON_YES = "YES"
    static let ALERT_BUTTON_NO = "NO"
    

    static  let StoryBoard = UIStoryboard(name: "Main", bundle: nil)
    //static  let appdelegate = UIApplication.shared.delegate as! AppDelegate
    
    static let FRAME_WIDTH = UIScreen.main.bounds.size.width
    static let FRAME_HEIGHT = UIScreen.main.bounds.size.height
    static let BUTTON_BORDER_GRAY_COLOR = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.2470588235)
    static let BUTTON_BORDER_BLACK_COLOR = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    
    public static let appColor = #colorLiteral(red: 0.007843137255, green: 0.2705882353, blue: 0.4784313725, alpha: 1)
    public static let selectedColor = #colorLiteral(red: 0.003921568627, green: 0.5411764706, blue: 0.7450980392, alpha: 1)
    public static let unSelectedColor = #colorLiteral(red: 0.7333333333, green: 0.8784313725, blue: 0.9294117647, alpha: 1)
    public static let appBackgroundColor = #colorLiteral(red: 0.937254902, green: 0.9764705882, blue: 0.9960784314, alpha: 1)
  
    static let USER_DEFAULT = UserDefaults.standard
    
    static let USER_ID = "userId"
    
    static let USER_NAME = "name"
    
    static let USER_DATA = "https://api.github.com/users?since="
    static let USER_DETAIL =  "https://api.github.com/users/"
    
    static let ENTITY_NAME = "TestUser"
}
