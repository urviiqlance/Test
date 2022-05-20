//
//  HomeVC.swift
//  Test
//
//  Created by Naresh iQlance on 19/05/22.
//

import UIKit
import ObjectMapper
import Alamofire

class HomeVC: UIViewController {
    
    //MARK:-  Outlets and Variable Declarations
    @IBOutlet weak var viewSearch: UIView!
    @IBOutlet weak var txtSearch: UITextField!
    
    @IBOutlet weak var tblView: UITableView!
    
    var arrHomeData = [[String:Any]]()
    var arrFilterData = [TestUser]()
    var arrCoreHome = [TestUser]()
    var isFiltered = false
    
    var page = 0
    var lastPage = 0
    let spinner = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.medium)
    
    //MARK:- 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = Constant.appBackgroundColor
        self.tblView.registerXIB(name: "HomeTblCell")
        
        self.callApi(page: page, isLoader: true)
        self.arrCoreHome = DatabaseHelper.shareInstence.getData()
        self.arrFilterData = self.arrCoreHome
        self.tblView.reloadData()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }
    
    
    //MARK:-  Buttons Clicked Action
    
    //MARK:-  Functions
    func callApi(page: Int,isLoader: Bool)  {
        
        if isLoader{
            CustomLoader.sharedInstance.showActivityIndicatory(vc: self)
        }
        
        APIManager.getAPI(url: Constant.USER_DATA + "\(page)",isFalg: true) { isSuccess, message, reponse in
            self.arrHomeData = reponse
            
            for (i, _) in self.arrHomeData.enumerated() {
                print("dsfdsf",self.arrHomeData[i]["avatar_url"] ?? "")
                let dict :  [String : String]  = ["name" : "\(self.arrHomeData[i]["login"] ?? "")", "followers" : "\(self.arrHomeData[i]["followers"] ?? "")" , "following": "\(self.arrHomeData[i]["following"] ?? "")" , "blog": "\(self.arrHomeData[i]["blog"] ?? "")","company": "\(self.arrHomeData[i]["company"] ?? "")","detail": "\(self.arrHomeData[i]["node_id"] ?? "")","avatar_url": "\(self.arrHomeData[i]["avatar_url"] ?? "")","notes": "\(self.arrHomeData[i]["notes"] ?? "write note")"]
                DatabaseHelper.shareInstence.save(object: dict)
            }
            
            
            DispatchQueue.main.async {
                self.tblView.layoutIfNeeded()
                self.arrCoreHome = DatabaseHelper.shareInstence.getData()
                self.arrFilterData = self.arrCoreHome
                self.tblView.reloadData()
                self.spinner.stopAnimating()
                CustomLoader.sharedInstance.hideActivityIndicator()
            }
            self.spinner.stopAnimating()
            CustomLoader.sharedInstance.hideActivityIndicator()
        }
    }
    
}


//MARK:-  UITableViewDataSource Methods
extension HomeVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrCoreHome.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTblCell") as! HomeTblCell
        let arr = arrCoreHome[indexPath.row]
        cell.configureCell(arr: arr)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == arrCoreHome.count - 1{
            self.page = page + 1
            self.callApi(page: page + 1, isLoader: false)
        }
        
        let lastSectionIndex = tableView.numberOfSections - 1
            let lastRowIndex = tableView.numberOfRows(inSection: lastSectionIndex) - 1
            if indexPath.section ==  lastSectionIndex && indexPath.row == lastRowIndex {
               // print("this is the last cell")
                
                spinner.startAnimating()
                spinner.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: tableView.bounds.width, height: CGFloat(44))

                self.tblView.tableFooterView = spinner
                self.tblView.tableFooterView?.isHidden = false
            }
    }
}

//MARK:-  UITableViewDelegate Methods
extension HomeVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "HomeDetailVC") as! HomeDetailVC
        vc.strName = arrCoreHome[indexPath.row].name ?? ""
        vc.index = indexPath.row
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

//MARK:-  UITextfield delegate
extension HomeVC: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        isFiltered = true
        arrCoreHome = arrFilterData.filter{$0.name!.contains(textField.text ?? "", options: .caseInsensitive)}
        //println(searchResults.description)
        
        if arrCoreHome.count == 0 {
            print("dvdfv")
            self.arrCoreHome = self.arrFilterData
        } else {
            print("vdfvf")
        }
        
        if textField.text == ""{
            arrCoreHome = DatabaseHelper.shareInstence.getData()
        }
        
        textField.resignFirstResponder()
        tblView.reloadData()
        return true
    }
    
    
}
