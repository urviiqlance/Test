//
//  DatabaseHelper.swift
//  TestTheOneTech
//
//  Created by Hex006 on 14/04/22.
//

import Foundation
import CoreData
import UIKit

class DatabaseHelper {
    
    static let shareInstence = DatabaseHelper()
    
    let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    
    
    //MARK:- save data
    func save(object: [String:String]) {
        
        let homeData = NSEntityDescription.insertNewObject(forEntityName: Constant.ENTITY_NAME, into: context!) as! TestUser
        homeData.name = object["name"]
        homeData.followers = object["followers"]
        homeData.following = object["following"]
        homeData.blog = object["blog"]
        homeData.company = object["company"]
        homeData.detail = object["detail"]
        homeData.avatar_url = object["avatar_url"]
        homeData.notes = object["notes"]
        
        do {
            try context?.save()
        } catch  {
            print("data not save")
        }
    }
    
    //MARK:- get data
    func getData () -> [TestUser] {
        var homeData = [TestUser]()
        let featchData = NSFetchRequest<NSFetchRequestResult>(entityName: Constant.ENTITY_NAME)
        do {
            homeData = try context?.fetch(featchData) as! [TestUser]
        } catch  {
            print("no data found")
        }
        return homeData
    }
    
    //MARK:-  edit data
    func editData(object: [String:String] , i: Int)  {
        let homeData = getData()
        homeData[i].name = object["name"]
        homeData[i].followers = object["followers"]
        homeData[i].following = object["following"]
        homeData[i].blog = object["blog"]
        homeData[i].company = object["company"]
        homeData[i].detail = object["detail"]
        homeData[i].avatar_url = object["avatar_url"]
        homeData[i].notes = object["notes"]
        
        do{
            try context?.save()
        }catch{
            print("data is not edit")
        }
    }
}
