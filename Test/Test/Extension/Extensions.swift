//
//  Extensions.swift
//  Tasker
//
//  Created by XcelTec-053 on 17/09/19.
//  Copyright © 2019 xceltec. All rights reserved.
//

import Foundation
import UIKit
//import BadgeHub



extension UIView {
    //MARK:- gradient setUp
    enum GradientDirection {
        case horizontal
        case vertical
    }
    
    func fillColors(_ colors: [UIColor], withPercentage percentages: [Double], direction: GradientDirection = .horizontal) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        var colorsArray: [CGColor] = []
        var locationsArray: [NSNumber] = []
        var total = 0.0
        locationsArray.append(0.0)
        for (index, color) in colors.enumerated() {
            // append same color twice
            colorsArray.append(color.cgColor)
            colorsArray.append(color.cgColor)
            // Calculating locations Percentage of each
            if index + 1 < percentages.count {
                total += percentages[index]
                let location = NSNumber(value: total / 100)
                locationsArray.append(location)
                locationsArray.append(location)
            }
        }
        locationsArray.append(1.0)
        if direction == .horizontal {
            gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
            gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.0)
        } else {
            gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
            gradientLayer.endPoint = CGPoint(x: 0.0, y: 1.0)
        }
        gradientLayer.colors = colorsArray
        gradientLayer.locations = locationsArray
        backgroundColor = .clear
        layer.addSublayer(gradientLayer)
    }
    func applyGradient(isVertical: Bool, colorArray: [UIColor]) {
        layer.sublayers?.filter({ $0 is CAGradientLayer }).forEach({ $0.removeFromSuperlayer() })
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = colorArray.map({ $0.cgColor })
        if isVertical {
            //top to bottom
            gradientLayer.locations = [0.0, 1.0]
        } else {
            //left to right
            gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
            gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        }
        
        backgroundColor = .clear
        gradientLayer.frame = bounds
        layer.insertSublayer(gradientLayer, at: 0)
    }
    //MARK:- Layer setUp
    func makeRoundViewCorner( radius : CGFloat)
    {
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
    }
    @IBInspectable var circular:Bool {
        set{
            if newValue == true {
                self.layer.cornerRadius = self.bounds.size.height/2
                self.layer.masksToBounds = true
            }
        }
        get{
            return self.circular
        }
    }
    @IBInspectable var cornerRadius: CGFloat {
        
        get{
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        get {
            return UIColor(cgColor: layer.borderColor!)
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
    //MARK:- Corner radius with shadow setUp
    func dropShadow(scale: Bool = true,radius:CGFloat = 1) {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: -10, height: 0)
        layer.shadowRadius = radius
        
        layer.shadowPath = UIBezierPath(rect: bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
    
    // OUTPUT 2
    func dropShadow(color: UIColor, opacity: Float = 0.5, offSet: CGSize, radius: CGFloat = 1, scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = offSet
        layer.shadowRadius = radius
        
        layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
    
    func addShadowToView(color: UIColor = UIColor.lightGray, cornerRadius: CGFloat) {
        
        self.backgroundColor = UIColor.white
        self.layer.masksToBounds = false
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.layer.shadowOpacity = 0.5
        self.backgroundColor = .white
        self.layer.cornerRadius = cornerRadius
    }
    func makeCardViewShadowWith(cornerRadius:CGFloat=10.0){
        self.layer.cornerRadius = cornerRadius
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        self.layer.shadowRadius = 10.0
        self.layer.shadowOpacity = 0.7
    }
    func bottomShadow(shadowRadius: CGFloat = 10.0){
        self.layer.masksToBounds = false
        self.layer.shadowRadius = shadowRadius
        self.layer.shadowOpacity = 1.0
        self.layer.shadowColor = UIColor.lightGray.cgColor
        self.layer.shadowOffset = CGSize(width: 0 , height:5)
    }
}

extension String {
    
    var decodeEmoji: String{
        let data = self.data(using: String.Encoding.utf8);
        let decodedStr = NSString(data: data!, encoding: String.Encoding.nonLossyASCII.rawValue)
        if let str = decodedStr{
            return str as String
        }
        return self
    }
    var encodeEmoji:String{
        let data = self.data(using: .nonLossyASCII, allowLossyConversion: true)!
        
        let encodeStr = String(data: data, encoding: .utf8);
        if let str = encodeStr{
            return str as String
        }
        return self
    }
    var toHexa:String{
        let data = Data(self.utf8)
        let hexString = data.map{ String(format:"%02x", $0) }.joined()
        if hexString != nil{
            return hexString
        }
        return self
    }
    
    
    mutating func messageTabUTCToLocal() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        let dt = dateFormatter.date(from: self)
        
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: dt ?? Date())
    }
    
    mutating func listTimeserverToLocal() -> String {
        let dateFormatter = DateFormatter()
        if self.contains("am") || self.contains("pm"){
            dateFormatter.dateFormat = "h:mm a"
        }else if self.contains("Yesterday") {
            return self
        }else{
            dateFormatter.dateFormat = "dd/MM/yyyy"
        }
        
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        let dt = dateFormatter.date(from: self)
        
        dateFormatter.timeZone = TimeZone.current
        if self.contains("am") || self.contains("pm"){
            dateFormatter.dateFormat = "h:mm a"
        }else{
            dateFormatter.dateFormat = "dd/MM/yyyy"
        }
        
        return dateFormatter.string(from: dt ?? Date())
    }
    mutating func chatSectionDate() -> String{
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "dd-MM-yyyy"
        dateformatter.timeZone = NSTimeZone.local
        let todayDate = dateformatter.string(from: Date())
        let dateToday = dateformatter.date(from: todayDate)!
        let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: dateToday)
        let strYesterdayDate = dateformatter.string(from: yesterday!)
        if todayDate == self{
            return "Today"
        }else if strYesterdayDate == self{
            return "Yesterday"
        }else{
            return self
        }
    }
    
    mutating func serverToLocalNew() -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        //let timeZone = Utility.shared.getLoggedInUser(.serverTimeZone)
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        
        let dt = dateFormatter.date(from: self)
        dateFormatter.timeZone = NSTimeZone.local
        dateFormatter.dateFormat = "h:mm a"
        
        return dateFormatter.string(from: dt ?? Date())
    }
    
    mutating func serverToLocal() -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy HH:mm:ss"
        //let timeZone = Utility.shared.getLoggedInUser(.serverTimeZone)
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        
        let dt = dateFormatter.date(from: self)
        dateFormatter.timeZone = NSTimeZone.local
        dateFormatter.dateFormat = "h:mm a"
        
        return dateFormatter.string(from: dt ?? Date()) 
    }
    mutating func OfflineToLocal() -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        //let timeZone = Utility.shared.getLoggedInUser(.serverTimeZone)
        // dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        
        let dt = dateFormatter.date(from: self)
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.dateFormat = "h:mm a"
        
        return dateFormatter.string(from: dt ?? Date())
    }
    mutating func performedServerToLocal() -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        //let timeZone = Utility.shared.getLoggedInUser(.serverTimeZone)
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        
        let dt = dateFormatter.date(from: self)
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.dateFormat = "yy-MM-dd"
        
        return dateFormatter.string(from: dt ?? Date())
    }
    
    //MARK: - Bold and Underline String for Chat Method
    func slice(from: String, to: String) -> String? {
        return (range(of: from)?.upperBound).flatMap { substringFrom in
            (range(of: to, range: substringFrom..<endIndex)?.lowerBound).map { substringTo in
                String(self[substringFrom..<substringTo])
            }
        }
    }
    
    func getCustomFont()->NSAttributedString{
        var strBold = self.slice(from: "**", to: "**")
        var fullString:String = self
        var attributedString = NSMutableAttributedString(string: self)
        if strBold != nil{
            // make bold
            strBold = strBold?.replacingOccurrences(of: "**", with: "")
            fullString = fullString.replacingOccurrences(of: "**", with: "")
            attributedString = NSMutableAttributedString(string:fullString)
            let boldRange = (fullString as NSString).range(of: strBold!)
            
            attributedString.addAttribute(NSAttributedString.Key.font, value: UIFont.init(name: "Arial-BoldMT", size: 17)! , range: boldRange)
            
        }
        var strUnderLine = self.slice(from: "_", to: "_")
        if strUnderLine != nil{
            // make under line
            strUnderLine = strUnderLine?.replacingOccurrences(of: "__", with: "")
            fullString = fullString.replacingOccurrences(of: "__", with: "")
            let underLineRange = (fullString as NSString).range(of: strUnderLine!)
            
            //  attributedString = NSMutableAttributedString(string:fullString)
            
            attributedString.addAttribute(NSAttributedString.Key.underlineStyle , value: NSUnderlineStyle.single.rawValue, range: underLineRange)
        }
        attributedString = attributedString.stringWithString(stringToReplace: "_", replacedWithString: "")
        return attributedString
    }
    func removeString(completeString:String , remove: String) -> String {
        let aString = completeString
        let newString = aString.replacingOccurrences(of: "", with: remove, options: .literal, range: nil)
        return newString
    }
}
extension UIImage {
    
    public convenience init?(_ systemItem: UIBarButtonItem.SystemItem) {
        
        guard let sysImage = UIImage.imageFrom(systemItem: systemItem)?.cgImage else {
            return nil
        }
        
        self.init(cgImage: sysImage)
    }
    
    private class func imageFrom(systemItem: UIBarButtonItem.SystemItem) -> UIImage? {
        
        let sysBarButtonItem = UIBarButtonItem(barButtonSystemItem: systemItem, target: nil, action: nil)
        
        //MARK:- Adding barButton into tool bar and rendering it.
        let toolBar = UIToolbar()
        toolBar.setItems([sysBarButtonItem], animated: false)
        toolBar.snapshotView(afterScreenUpdates: true)
        
        if  let buttonView = sysBarButtonItem.value(forKey: "view") as? UIView{
            for subView in buttonView.subviews {
                if subView is UIButton {
                    let button = subView as! UIButton
                    let image = button.imageView!.image!
                    return image
                }
            }
        }
        return nil
    }
    
    //MARK: - GET THUMBNAIL IMAGE FUNCTION
    func thumbnail() -> UIImage? {
        guard let image = self as? UIImage,image != nil else {
            return nil
        }
        let size = CGSize(width: 80, height: 80)
        let renderer = UIGraphicsImageRenderer(size: size)
        return renderer.image { (context) in
            image.draw(in: CGRect(origin: .zero, size: size))
        }
    }
}

extension CGFloat {
    static func random() -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
}


extension UIDevice {
    var isSimulator: Bool {
        #if IOS_SIMULATOR
        return true
        #else
        return false
        #endif
    }
}


extension UITextView :UITextViewDelegate
{
    
    /// Resize the placeholder when the UITextView bounds change
    override open var bounds: CGRect {
        didSet {
            self.resizePlaceholder()
        }
    }
    
    /// The UITextView placeholder text
    public var placeholder: String? {
        get {
            var placeholderText: String?
            
            if let placeholderLabel = self.viewWithTag(100) as? UILabel {
                placeholderText = placeholderLabel.text
            }
            
            return placeholderText
        }
        set {
            if let placeholderLabel = self.viewWithTag(100) as! UILabel? {
                placeholderLabel.text = newValue
                placeholderLabel.sizeToFit()
            } else {
                self.addPlaceholder(newValue!)
            }
        }
    }
    
    /// When the UITextView did change, show or hide the label based on if the UITextView is empty or not
    ///
    /// - Parameter textView: The UITextView that got updated
    public func textViewDidChange(_ textView: UITextView) {
        if let placeholderLabel = self.viewWithTag(100) as? UILabel {
            placeholderLabel.isHidden = self.text.count > 0
        }
    }
    
    /// Resize the placeholder UILabel to make sure it's in the same position as the UITextView text
    private func resizePlaceholder() {
        if let placeholderLabel = self.viewWithTag(100) as! UILabel? {
            let labelX = self.textContainer.lineFragmentPadding
            let labelY = self.textContainerInset.top - 2
            let labelWidth = self.frame.width - (labelX * 2)
            let labelHeight = placeholderLabel.frame.height
            
            placeholderLabel.frame = CGRect(x: labelX, y: labelY, width: labelWidth, height: labelHeight)
        }
    }
    
    /// Adds a placeholder UILabel to this UITextView
    private func addPlaceholder(_ placeholderText: String) {
        let placeholderLabel = UILabel()
        
        placeholderLabel.text = placeholderText
        placeholderLabel.sizeToFit()
        
        placeholderLabel.font = self.font
        placeholderLabel.textColor = UIColor.lightGray
        placeholderLabel.tag = 100
        
        placeholderLabel.isHidden = self.text.count > 0
        
        self.addSubview(placeholderLabel)
        self.resizePlaceholder()
        self.delegate = self
    }
}

extension Data {
    func getDocumentsDirectory() -> NSString {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let documentsDirectory = paths[0]
        return documentsDirectory as NSString
    }
    
    func dataToFile(fileName: String) -> NSURL? {
        
        
        let data = self
        
        
        let filePath = getDocumentsDirectory().appendingPathComponent(fileName)
        
        do {
            // Write the file from data into the filepath (if there will be an error, the code jumps to the catch block below)
            try data.write(to: URL(fileURLWithPath: filePath))
            
            // Returns the URL where the new file is located in NSURL
            return NSURL(fileURLWithPath: filePath)
            
        } catch {
            // Prints the localized description of the error from the do block
            print("Error writing the file: \(error.localizedDescription)")
        }
        
        // Returns nil if there was an error in the do-catch -block
        return nil
        
    }
    
    
}


extension NSAttributedString {
    func stringWithString(stringToReplace: String, replacedWithString newStringPart: String) -> NSMutableAttributedString
    {
        let mutableAttributedString = mutableCopy() as! NSMutableAttributedString
        let mutableString = mutableAttributedString.mutableString
        while mutableString.contains(stringToReplace) {
            let rangeOfStringToBeReplaced = mutableString.range(of: stringToReplace)
            mutableAttributedString.replaceCharacters(in: rangeOfStringToBeReplaced, with: newStringPart)
        }
        return mutableAttributedString
    }
}

extension UIApplication {
    class func topViewController(base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        
        if let nav = base as? UINavigationController {
            return topViewController(base: nav.visibleViewController)
        }
        
        if let tab = base as? UITabBarController {
            let moreNavigationController = tab.moreNavigationController
            
            if let top = moreNavigationController.topViewController, top.view.window != nil {
                return topViewController(base: top)
            } else if let selected = tab.selectedViewController {
                return topViewController(base: selected)
            }
        }
        
        if let presented = base?.presentedViewController {
            return topViewController(base: presented)
        }
        
        return base
    }
}

private var KeyMaxLength: Int = 0
extension UITextField{
    public var hasValidEmail: Bool {
        return text!.range(of: "(?:[a-z0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[a-z0-9!#$%\\&'*+/=?\\^_`{|}" +
                            "~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\" +
                            "x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-z0-9](?:[a-" +
                            "z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\\[(?:(?:25[0-5" +
                            "]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-" +
                            "9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21" +
                            "-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])",
                           options: String.CompareOptions.regularExpression,
                           range: nil, locale: nil) != nil
    }
    @IBInspectable var placeHolderColor: UIColor? {
        get {
            return self.placeHolderColor
        }
        set {
            self.attributedPlaceholder = NSAttributedString(string:self.placeholder != nil ? self.placeholder! : "", attributes:[NSAttributedString.Key.foregroundColor: newValue!])
        }
    }
    //MARK:- Add Padding left-right
    @IBInspectable var leftPadding: CGFloat {
        get {
            return leftView?.frame.size.width ?? 0.0
        }
        set {
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: newValue, height: frame.size.height))
            leftView = paddingView
            leftViewMode = .always
        }
    }
    @IBInspectable var rightPadding: CGFloat {
        get {
            return rightView?.frame.size.width ?? 0.0
        }
        set {
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: newValue, height: frame.size.height))
            rightView = paddingView
            rightViewMode = .always
        }
    }
    //MARK:- Add done in keyboard accessory
    @IBInspectable var doneAccessory: Bool{
        get{
            return self.doneAccessory
        }
        set(hasDone){
            if hasDone{
                addDoneButtonOnKeyboard()
            }
        }
    }
    
    func addDoneButtonOnKeyboard()
    {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        doneToolbar.barStyle = .default
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.doneButtonAction))
        
        let items = [flexSpace, done]
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        
        self.inputAccessoryView = doneToolbar
    }
    
    @objc func doneButtonAction(){
        self.resignFirstResponder()
    }
    
    func setIcon(_ image: UIImage) {
        let iconView = UIImageView(frame:
                                    CGRect(x: 10, y: 5, width: 40, height: 40))
        iconView.image = image
        let iconContainerView: UIView = UIView(frame:
                                                CGRect(x: 20, y: 0, width: 40, height: 40))
        iconContainerView.addSubview(iconView)
        leftView = iconContainerView
        leftViewMode = .always
    }
    func setUnderLine(color:UIColor) {
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(origin: CGPoint(x: 0, y:self.frame.height - 1), size: CGSize(width: self.frame.width*1.17, height:  1))
        bottomLine.backgroundColor = color.cgColor
        self.borderStyle = UITextField.BorderStyle.none
        self.layer.addSublayer(bottomLine)
    }
    //MARK:-Set Right button in textfield
    func setRightSideButton(strImgName:String,color:UIColor, _ closure: @escaping ()->()) {
        let button = UIButton(type: .custom)
        let size: CGFloat = 25.0
        if let image = UIImage(named: strImgName){
            let aTempImg = image.withRenderingMode(.alwaysTemplate)
            button.setImage(aTempImg, for: .normal)
            button.imageEdgeInsets = UIEdgeInsets(top: 7, left: 7, bottom: 7, right: 7)
            button.frame = CGRect(x: CGFloat(self.frame.size.width - size), y: CGFloat(5), width: size, height: size)
            button.contentMode = UIView.ContentMode.scaleAspectFit
            self.rightView = button
            self.rightViewMode = .always
            button.tintColor = color
            button.addAction {
                closure()
            }
        }
    }
    //MARK:- Create password textField
    func setPasswordButton(strNormalImgName:String,strSelectedImg:String,color:UIColor, _ closure: @escaping ()->()) {
        let button = UIButton(type: .custom)
        let size: CGFloat = 25.0
        
        button.imageEdgeInsets = UIEdgeInsets(top: 7, left: 7, bottom: 7, right: 7)
        button.frame = CGRect(x: CGFloat(self.frame.size.width - size), y: CGFloat(5), width: size, height: size)
        button.contentMode = UIView.ContentMode.scaleAspectFit
        if let image = UIImage(named: strNormalImgName){
            let aTempImg = image.withRenderingMode(.alwaysTemplate)
            button.setImage(aTempImg, for: .normal)
            self.isSecureTextEntry = true
        }
        self.rightView = button
        self.rightViewMode = .always
        if let aColor = color as? UIColor,aColor != nil{
            button.tintColor = color
        }else{
            button.tintColor = self.placeHolderColor
        }
        
        button.addAction {
            button.isSelected = !button.isSelected
            if button.isSelected{
                if let image = UIImage(named: strSelectedImg){
                    let aTempImg = image.withRenderingMode(.alwaysTemplate)
                    button.setImage(aTempImg, for: .normal)
                    self.isSecureTextEntry = false
                }
            }else{
                if let image = UIImage(named: strNormalImgName){
                    let aTempImg = image.withRenderingMode(.alwaysTemplate)
                    button.setImage(aTempImg, for: .normal)
                    self.isSecureTextEntry = true
                }
            }
            closure()
        }
    }
    //MARK:-connect all textfield
    class func connectAllTxtFieldFields(txtfields:[UITextField]) -> Void {
        guard let last = txtfields.last else {
            return
        }
        for i in 0 ..< txtfields.count - 1 {
            txtfields[i].returnKeyType = .next
            txtfields[i].addTarget(txtfields[i+1], action: #selector(UIResponder.becomeFirstResponder), for: .editingDidEndOnExit)
        }
        last.returnKeyType = .done
        last.addTarget(last, action: #selector(UIResponder.resignFirstResponder), for: .editingDidEndOnExit)
    }
    //MARK:-Add max Length
    @IBInspectable var maxLength: Int {
        get {
            if let length = objc_getAssociatedObject(self, &KeyMaxLength) as? Int {
                return length
            } else {
                return Int.max
            }
        }
        set {
            objc_setAssociatedObject(self, &KeyMaxLength, newValue, .OBJC_ASSOCIATION_RETAIN)
            addTarget(self, action: #selector(checkMaxLength), for: .editingChanged)
        }
    }
    
    @objc func checkMaxLength(textField: UITextField) {
        guard let prospectiveText = self.text,
              prospectiveText.count > maxLength
        else {
            return
        }
        
        let selection = selectedTextRange
        let maxCharIndex = prospectiveText.index(prospectiveText.startIndex, offsetBy: maxLength)
        text = String(prospectiveText[..<maxCharIndex])//prospectiveText.substring(to: maxCharIndex)
        selectedTextRange = selection
    }
    
}

extension UIImageView {
    func setTintColor(color: UIColor) {
        let templateImage = self.image?.withRenderingMode(.alwaysTemplate)
        self.image = templateImage
        self.tintColor = color
    }
}

extension UIViewController{
    var hideKeyboardAllAround : Bool {
        set{
            if newValue == true {
                let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
                tap.cancelsTouchesInView = false
                self.view.addGestureRecognizer(tap)
            }
        }
        get{
            return false
        }
    }
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }

}
//MARK:- UITableview
extension UITableView {
    func isLastVisibleCell(at indexPath: IndexPath) -> Bool {
        guard let lastIndexPath = indexPathsForVisibleRows?.last else {
            return false
        }
        
        return lastIndexPath == indexPath
    }
}
//MARK:- Array Last Index
extension Array {
    var last: Element {
        return self[self.endIndex - 1]
    }
}

//MARK:- UICharacter Set
extension Character {

    func isUpperCase() -> Bool {
        return CharacterSet.uppercaseLetters.contains(self.unicodeScalars.first!)
    }
    
    func isLowerCase() -> Bool {
        return CharacterSet.lowercaseLetters.contains(self.unicodeScalars.first!)
    }

}
//MARK:- Button Control
extension UIControl {
    func addAction(for controlEvents: UIControl.Event = .touchUpInside, _ closure: @escaping ()->()) {
        let sleeve = ClosureSleeve(closure)
        addTarget(sleeve, action: #selector(ClosureSleeve.invoke), for: controlEvents)
        objc_setAssociatedObject(self, "[\(arc4random())]", sleeve, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
    }
}
@objc class ClosureSleeve: NSObject {
    let closure: ()->()
    
    init (_ closure: @escaping ()->()) {
        self.closure = closure
    }
    
    @objc func invoke () {
        closure()
    }
}

//MARK:- UIView Dotted Line
extension UIView {
   func createDottedLine(width: CGFloat, color: CGColor) {
      let caShapeLayer = CAShapeLayer()
      caShapeLayer.strokeColor = color
      caShapeLayer.lineWidth = width
      caShapeLayer.lineDashPattern = [2,3]
      let cgPath = CGMutablePath()
      let cgPoint = [CGPoint(x: 0, y: 0), CGPoint(x: self.frame.width, y: 0)]
      cgPath.addLines(between: cgPoint)
      caShapeLayer.path = cgPath
      layer.addSublayer(caShapeLayer)
   }
    
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
         let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
         let mask = CAShapeLayer()
         mask.path = path.cgPath
         layer.mask = mask
     }
}

extension NSAttributedString{
    static func makeHyperLink(for path: String,in string: String,as substring: String) -> NSAttributedString{
        let nsString = NSString(string: string)
        let subStringRange = nsString.range(of: substring)
        let attributedString = NSMutableAttributedString(string: string)
        attributedString.addAttribute(.link, value: path, range: subStringRange)
        return attributedString
    }
}

extension UITableView {

    func registerXIB(name: String) {
        self.register(UINib(nibName: name, bundle: nil), forCellReuseIdentifier: name)
    }
}

extension Bool: ExpressibleByIntegerLiteral {
    public init(integerLiteral value: Int) {
        self = value != 0
    }
}

extension String {
    func contains(_ string: String, options: CompareOptions) -> Bool {
        return range(of: string, options: options) != nil
    }
}

extension UIViewController{
    func showAlertWithOkButton(message: String, _ completion: (() -> Void)? = nil) {
        
        let alert = UIAlertController(title: "Text", message: message, preferredStyle: .alert)
        
        let OKAction = UIAlertAction(title: "OK", style: .default) { (alert) in
            completion?()
        }
        alert.addAction(OKAction)
        
        self.present(vc: alert)
    }
    func showAlertWithTwoButtons(message: String, btn1Name: String, btn2Name: String, completion: @escaping ((_ btnClickedIndex: Int) -> Void)) {
        
        let alert = UIAlertController(title: "Test", message: message, preferredStyle: .alert)
        
        let action1 = UIAlertAction(title: btn1Name, style: .default) { (action1) in
            completion(1)
        }
        alert.addAction(action1)
        
        let action2 = UIAlertAction(title: btn2Name, style: .default) { (action2) in
            completion(2)
        }
        alert.addAction(action2)
        self.present(vc: alert)
    }
    
    private func present(vc: UIViewController) {
        
        if let nav = self.navigationController {
            if let presentedVC = nav.presentedViewController {
                presentedVC.present(vc, animated: true, completion: nil)
            } else {
                self.navigationController?.present(vc, animated: true, completion: nil)
            }
        } else {
            self.present(vc, animated: true, completion: nil)
        }
    }
}


