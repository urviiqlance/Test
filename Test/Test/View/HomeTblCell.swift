//
//  HomeTblCell.swift
//  Test
//
//  Created by Naresh iQlance on 19/05/22.
//

import UIKit

class HomeTblCell: UITableViewCell {
    
    @IBOutlet weak var imgProfile: UIImageView!
    
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var lblUserDetail: UILabel!
    @IBOutlet weak var imgFile: UIImageView!
    @IBOutlet weak var btnFile: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func configureCell(arr: TestUser)  {
        
        self.imgFile.image = UIImage(named: "ic_file")?.withRenderingMode(.alwaysTemplate)
        self.btnFile.tintColor = .white
        self.btnFile.isHidden = true
        
        if let url = URL(string: arr.avatar_url ?? "ic_profile") {
            
            DispatchQueue.global().async {
                // Fetch Image Data
                if let data = try? Data(contentsOf: url) {
                    DispatchQueue.main.async {
                        // Create Image and Update Image View
                        self.imgProfile.image = UIImage(data: data)
                    }
                }
            }
        }
        
        self.lblUserName.text = arr.name
        self.lblUserDetail.text = arr.detail
        
        if arr.notes == ""{
            self.imgFile.isHidden = true
        }else{
            self.imgFile.isHidden = false
        }
    }
    
}
