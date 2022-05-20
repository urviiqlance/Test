//
//  Utility.swift
//  All_Utilities
//
//  Created by Hexagon on 31/12/20.
//

import Foundation
import UIKit


class Utility: NSObject {
    static let shared = Utility()
    
    
    //MARK:- Add Alert
    func showAlert(_ vc:UIViewController,strTitle:String) {
        let alert = UIAlertController(title: "", message: strTitle, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        vc.present(alert, animated: true, completion: nil)
    }
    func showAlertWithBackAction(vc:UIViewController,strTitle:String,StrMessage:String ,isArabic:Bool = true, handler:@escaping ((String)->Void)) {
        let alert = UIAlertController(title: strTitle, message: StrMessage, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: {(action:UIAlertAction!) in
            handler("Ok Press")
        }))
        vc.present(alert, animated: true, completion: nil)
    }
    
    class func showAlertWithButtons(_ onController:UIViewController?, title:String?,message:String? = nil ,cancelButton:String = "OK",buttons:[String]? = nil,actions:((_ alertAction:UIAlertAction,_ strSelected:String)->())? = nil) {
        // make sure it would be run on  main queue
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        if let _buttons = buttons {
            for button in _buttons {
                let action = UIAlertAction(title: button, style: .default) { (action) in
                   // let index = _buttons.firstIndex(of: action.title!)
                    actions?(action,button)
                }
                alertController.addAction(action)
            }
        }
        let action = UIAlertAction(title: cancelButton, style: .cancel) { (action) in
            alertController.dismiss(animated: true, completion: nil)
            actions?(action,cancelButton)
        }
        alertController.addAction(action)
        if let onController = onController{
            onController.present(alertController, animated: true, completion: nil)
        }else{
            //            let appdel = UIApplication.shared.delegate as! AppDelegate
            //            appdel.window!.rootViewController?.present(alertController, animated: true, completion: nil)
        }
    }
    
    func isValidEmail(strEmail:String) -> Bool
    {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: strEmail)
    }
    func validatePhoneNo(value: String) -> Bool {
        let PHONE_REGEX = "^((0091)|(\\+91)|0?)[6789]{1}\\d{9}$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
        let result =  phoneTest.evaluate(with: value)
        return result
    }
    func isValidInput(Input:String) -> Bool {
        return Input.range(of: "[A-Z][a-zA-Z]*", options: .regularExpression) != nil
    }
    
    func isValidPassword(testStr:String?) -> Bool {
        //guard testStr != nil else { return false }
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,16}")
        return passwordTest.evaluate(with: testStr)
    }
    
    func matches(for regex: String, in text: String) -> [String] {

        do {
            let regex = try NSRegularExpression(pattern: regex)
            let results = regex.matches(in: text,
                                        range: NSRange(text.startIndex..., in: text))
            return results.map {
                String(text[Range($0.range, in: text)!])
            }
        } catch let error {
            print("invalid regex: \(error.localizedDescription)")
            return []
        }
    }

    //MARK:- Convert json data
       func convertIntoJSONString(arrayObject: [Any]) -> String? {

           do {
               let jsonData: Data = try JSONSerialization.data(withJSONObject: arrayObject, options: [])
               if  let jsonString = NSString(data: jsonData, encoding: String.Encoding.utf8.rawValue) {
                   return jsonString as String
               }
               
           } catch let error as NSError {
               print("Array convertIntoJSON - \(error.description)")
           }
           return nil
       }
    
    //MARK:- UICollection View cell size
    func estimatedFrame(text: String, font: UIFont) -> CGRect {
        let size = CGSize(width: 200, height: 1000) // temporary size
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        return NSString(string: text).boundingRect(with: size,
                                                   options: options,
                                                   attributes: [NSAttributedString.Key.font: font],
                                                   context: nil)
    }
    
    

    //MARK:- Show alert
//    func showAlert(message: String,vc: UIViewController){
//        let alertController = UIAlertController(title: "", message: message, preferredStyle: .alert)
//
//        // Create the actions
//        let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) {
//            UIAlertAction in
//            CustomLoader.shared.hideActivityIndicator()
//            vc.dismiss(animated: true, completion: nil)
//        }
//
//        // Add the actions
//        alertController.addAction(okAction)
//
//        // Present the controller
//        vc.present(alertController, animated: true, completion: nil)
//    }
    
    //MARK:- Remove string
    func removeText (strString: String,strRemoveString: String) -> String {
        let parsed = strString.replacingOccurrences(of: strRemoveString, with: "")
        return parsed
    }
    
    //MARK:- Random String Generate
    func randomString(length: Int) -> String {
      let letters = "0123456789"
      return String((0..<length).map{ _ in letters.randomElement()! })
    }
    
    //MARK:- UserDefault store key
    func isKeyPresentInUserDefaults(key: String) -> Bool {
        return UserDefaults.standard.object(forKey: key) != nil
    }
    

}
