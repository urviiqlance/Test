//
//  APIManager.swift
//  Highburnation
//
//  Created by Naresh iQlance on 21/04/21.
//

import UIKit

let WSTimeOut : TimeInterval = 180
let errorDict : String = "error"

enum HtttpType: String {
    case POST = "POST"
    case GET  = "GET"
}

enum flag: Bool {
    case array
    case dict
}

class APIManager: NSObject {
    
    
    static let sharedInstance: APIManager = {
        
        let instance = APIManager()
        return instance
    }()
    private override init() {}
    
    typealias CompletionHandler<T:Codable> = ((Result<T,Error>) -> Void)
    
    let encoder = JSONEncoder()
    
    func parseAPIKeyWithURLGET<T:Codable>(_ WS_URL : String, isFalg: Bool = true, showLoadingIndicator : Bool, ModelType:T.Type,complitionHandler:@escaping CompletionHandler<T>)
    {
        
        let jsonRequest: NSMutableURLRequest = NSMutableURLRequest()
        jsonRequest.url = URL(string: WS_URL)!
        jsonRequest.httpMethod = "GET"
        jsonRequest.timeoutInterval = WSTimeOut
        
        
        let task = URLSession.shared.dataTask(with: jsonRequest as URLRequest) { data, response, error in
            
            if let httpResponse = response as? HTTPURLResponse {
                print("error \(httpResponse.statusCode)")
                if httpResponse.statusCode == 401 {
                    return
                }
            }
          
            if isFalg {
                if response != nil {
                    do {
                        let jsonResult = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! [[String:Any]]
                        
                        for i in 0 ..< jsonResult.count {
                            let ava = Home(login: "\(jsonResult[i]["login"] ?? "")", id: 0, nodeID: "\(jsonResult[i]["node_id"] ?? "")", avatarURL: "\(jsonResult[i]["avatar_url"] ?? "")", gravatarID: "", url: "", htmlURL: "", followersURL: "", followingURL: "", gistsURL: "", starredURL: "", subscriptionsURL: "", organizationsURL: "", reposURL: "", eventsURL: "", receivedEventsURL: "", type: TypeEnum.user, siteAdmin: true, name: "\(jsonResult[i]["name"] ?? "")", company: "\(jsonResult[i]["company"] ?? "")", blog: "\(jsonResult[i]["blog"] ?? "")", location: "", email: "", hireable: "", bio: "", twitterUsername: "", publicRepos: 0, publicGists: 0, followers: Int("\(jsonResult[i]["followers"] ?? "")") ?? 0, following: Int("\(jsonResult[i]["following"] ?? "")") ?? 0, createdAt: Date(), updatedAt: Date())
                            
                            //arr.append(ava)
                            complitionHandler(.success(ava as! T))
                        }
                        
                        
                    } catch let error as NSError {
                        print(error.localizedDescription)
                    }
                }else {
                    print("Please check your internet connection")
                }
            }else{
                
                if response != nil {
                    do {
                        let jsonResult = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! [String:Any]
                        
                        let ava = Home(login: "\(jsonResult["login"] ?? "")", id: 0, nodeID: "\(jsonResult["node_id"] ?? "")", avatarURL: "\(jsonResult["avatar_url"] ?? "")", gravatarID: "", url: "", htmlURL: "", followersURL: "", followingURL: "", gistsURL: "", starredURL: "", subscriptionsURL: "", organizationsURL: "", reposURL: "", eventsURL: "", receivedEventsURL: "", type: TypeEnum.user, siteAdmin: true, name: "\(jsonResult["name"] ?? "")", company: "\(jsonResult["company"] ?? "")", blog: "\(jsonResult["blog"] ?? "")", location: "", email: "", hireable: "", bio: "", twitterUsername: "", publicRepos: 0, publicGists: 0, followers: Int("\(jsonResult["followers"] ?? "")") ?? 0, following: Int("\(jsonResult["following"] ?? "")") ?? 0, createdAt: Date(), updatedAt: Date())
                        
                        complitionHandler(.success(ava as! T))
                
                    } catch let error as NSError {
                        print(error.localizedDescription)
                    }
                }else {
                    print("Please check your internet connection")
                }
                
            }
        }
        task.resume()
    }
    
    
}
