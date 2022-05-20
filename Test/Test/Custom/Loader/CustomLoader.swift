//
//  CustomLoader.swift
//  WooBox
//
//  Created by Hexagon on 08/07/20.
//  Copyright © 2020 Hexagon. All rights reserved.
//

import Foundation
import UIKit


class CustomLoader {
    
    var container: UIView = UIView()
    var loadingView: UIView = UIView()
    var activityIndicator: MaterialLoadingIndicator!
    var strLabel = UILabel()

    static let sharedInstance = CustomLoader() 
    
    //MARK:- Activity Indicator(Loader)
    
    func showActivityIndicatory(vc:UIViewController) {
        container.frame = vc.view.frame
        container.center = vc.view.center
        container.backgroundColor = UIColorFromHex(0x000000, alpha: 0.5)

        loadingView.frame = CGRect(x: 0, y: 0, width: 180, height: 120)//CGRectMake(0, 0, 80, 80)
        loadingView.center = vc.view.center
        loadingView.backgroundColor = .white//UIColorFromHex(0x444444, alpha: 0.7)
        loadingView.clipsToBounds = true
        loadingView.layer.cornerRadius = 10

        activityIndicator = MaterialLoadingIndicator(frame: CGRect(x:0, y:0, width: 40, height: 40))
        activityIndicator.indicatorColor = [#colorLiteral(red: 0.007843137255, green: 0.2705882353, blue: 0.4784313725, alpha: 1)]
        activityIndicator.center = CGPoint(x: loadingView.frame.size.width / 2, y: loadingView.frame.size.height / 2)
        
        strLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 160, height: 40))
        strLabel.text = "Please Wait...."
        strLabel.font = UIFont(name: "Montserrat-Regular", size: 17.0)
        strLabel.textColor = .gray
        strLabel.textAlignment = .center
        strLabel.center = CGPoint(x: activityIndicator.center.x , y: activityIndicator.center.y + 40)
        
        loadingView.addSubview(activityIndicator)
        loadingView.addSubview(strLabel)
        
        container.addSubview(loadingView)
        vc.view.addSubview(container)
        activityIndicator.startAnimating()
    }
    
    func hideActivityIndicator() {
        activityIndicator.stopAnimating()
        container.removeFromSuperview()
    }
    
    func UIColorFromHex(_ rgbValue:UInt32, alpha:Double=1.0)->UIColor {
        let red = CGFloat((rgbValue & 0xFF0000) >> 16)/256.0
        let green = CGFloat((rgbValue & 0xFF00) >> 8)/256.0
        let blue = CGFloat(rgbValue & 0xFF)/256.0
        return UIColor(red:red, green:green, blue:blue, alpha:CGFloat(alpha))
    }

}
