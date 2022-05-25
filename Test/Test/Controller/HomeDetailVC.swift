//
//  HomeDetailVC.swift
//  Test
//
//  Created by Naresh iQlance on 19/05/22.
//

import UIKit

class HomeDetailVC: UIViewController {

    //MARK:-  Outlets and Variable Declarations
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var imgProfile: UIImageView!
    
    
    @IBOutlet weak var lblFollowers: UILabel!
    @IBOutlet weak var lblFollowing: UILabel!
    
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblComapny: UILabel!
    @IBOutlet weak var lblBlog: UILabel!
    
    @IBOutlet weak var txtNote: UITextView!
    
    var strName = String()
    var index = Int()
    
    var arrHomeDataDetail : Home?
    var arrCoreHomeDetail = [TestUser]()
    
    //MARK:- 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.lblTitle.text = strName
        self.arrCoreHomeDetail.removeAll()
        self.callApiDetail(strName: strName, isLoader: true)
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }
    
    func callApiDetail(strName: String,isLoader: Bool)  {
        
        if isLoader {
            CustomLoader.sharedInstance.showActivityIndicatory(vc: self)
        }
        
        APIManager.sharedInstance.parseAPIKeyWithURLGET(String(format: Constant.USER_DETAIL + "\(strName)"), isFalg: false, showLoadingIndicator: true, ModelType: Home.self) { (response) in

            print("adsadjsnfsjdfhhj",response)
            switch response {
            case .success(let data):
        
                self.arrHomeDataDetail = data
                DispatchQueue.main.async {
                    
                    self.arrCoreHomeDetail = DatabaseHelper.shareInstence.getData()
        
                    if let url = URL(string: "\(self.arrHomeDataDetail?.avatarURL ?? "")" ) {
                        if let data = try? Data(contentsOf: url)
                        {
                            let image: UIImage = UIImage(data: data) ?? UIImage()
                            self.imgProfile.image = image
                        }
                    }
                    
                    self.txtNote.text = "\(self.arrCoreHomeDetail[self.index].notes ?? "write note")"
                    
                    if let name = self.arrHomeDataDetail?.name{
                        self.lblName.text = " Name: " + "\(name)"
                    }else{
                        self.lblName.isHidden = true
                    }
                    
                    if let company = self.arrHomeDataDetail?.company{
                        self.lblComapny.text = " Company: " + "\(company)"
                    }else{
                        self.lblComapny.isHidden = true
                    }
                    
                    if let following = self.arrHomeDataDetail?.following{
                        self.lblFollowing.text = " Following: " + "\(following)"
                    }else{
                        self.lblFollowing.isHidden = true
                    }
                    
                    if let blog = self.arrHomeDataDetail?.blog{
                        self.lblBlog.text = " Blog: " + "\(blog)"
                    }else{
                        self.lblBlog.isHidden = true
                    }
                    
                    if let followers = self.arrHomeDataDetail?.followers{
                        self.lblFollowers.text = " Followers: " + "\(followers)"
                    }else{
                        self.lblFollowers.isHidden = true
                    }
        
                    CustomLoader.sharedInstance.hideActivityIndicator()
                }
                
            case .failure(let error):
                print(error.localizedDescription)
                Utility.shared.showAlertWithBackAction(vc: self, strTitle: "Something went wrong!", StrMessage: error.localizedDescription, handler: { (value) in
                })
                break
            }
        }
    }
    
    
    //MARK:-  Buttons Clicked Action
    @IBAction func btnBackAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func btnSaveNoteAction(_ sender: UIButton) {
        
        if txtNote.text == "write note" || txtNote.text == "" {
            self.showAlertWithOkButton(message: "Please Enter Note")
        }else{
            let dict :  [String : String]  = ["name" : "\(self.arrCoreHomeDetail[index].name ?? "")", "followers" : "\(self.arrCoreHomeDetail[index].followers ?? "")" , "following": "\(self.arrCoreHomeDetail[index].following ?? "")" , "blog": "\(self.arrCoreHomeDetail[index].blog ?? "")","company": "\(self.arrCoreHomeDetail[index].company ?? "")","detail": "\(self.arrCoreHomeDetail[index].detail ?? "")","notes": "\(self.txtNote.text ?? "")","avatar_url": "\(self.arrCoreHomeDetail[index].avatar_url ?? "")"]
            DatabaseHelper.shareInstence.editData(object: dict, i: index)
        }
        
        self.navigationController?.popViewController(animated: true)
    }
    
    //MARK:-  Functions
}

extension HomeDetailVC: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if txtNote.text == "write note"{
            txtNote.text = ""
        }
    }
    

    func textViewDidEndEditing(_ textView: UITextView) {
        self.txtNote.resignFirstResponder()
    
    }
    
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        textView.resignFirstResponder()
        return true;
    }
    
}
