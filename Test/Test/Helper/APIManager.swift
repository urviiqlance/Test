//
//  APIManager.swift
//  Highburnation
//
//  Created by Naresh iQlance on 21/04/21.
//

import UIKit
import Alamofire
import AlamofireObjectMapper
import ObjectMapper

enum flag: Bool {
    case array
    case dict
}

class APIManager: NSObject {
    
    class func getAPI(url: String, isFalg: Bool = true, completion: @escaping ((_ isSuccess: Bool, _ message: String, _ response: [[String:Any]]) -> Void)) {
        
        func callAPi() {
            
            let headers = [
                "Content-Type": "application/x-www-form-urlencoded"
            ]
            
            print("URL: \(url)")
            print("Headers: \(String(describing: headers))")
            
            Alamofire.request(url, method: .get).responseJSON { (_ response: DataResponse) in
                
                if isFalg{
                    if let value = response.result.value  {
                        
                        print("Response: \(value)")
                        
                        if let res = value as? [[String : Any]] {
                            
                            print(res)
                            completion(false, response.error?.localizedDescription ?? "", res)
                            
                        } else {
                            print("dvvd")
                        }
                        
                    }else {
                        print("dvvd")
                    }
                }else{
                    
                        if let value = response.result.value  {
                            
                            print("Response: \(value)")
                            
                            if let res = value as? [String : Any] {
                                
                                print(res)
                                var arr = [[String:Any]]()
                                arr.append(res)
                                completion(false, response.error?.localizedDescription ?? "", arr)
                                
                            } else {
                                print("dvvd")
                            }
                            
                        }else {
                            print("dvvd")
                        }
                    
                }
                
                 
            }
        }
        
        checkInternetConnection {
            callAPi()
        }
    }
    
    private static var isInternetChecked = false
    
    private class func checkInternetConnection(completion: @escaping (() -> Void)) {
        
        if !isInternetChecked {
            
            if NetworkReachabilityManager()?.isReachable ?? false {
                completion()
            } else {
                
                isInternetChecked = true
                DispatchQueue.main.async {

                    //                    let viewController = UIApplication.shared.windows.first?.rootViewController
                    //                    viewController?.showAlertWithOkButton(message: "Please check your internet connection")
                }
            }
        }
    }
}
