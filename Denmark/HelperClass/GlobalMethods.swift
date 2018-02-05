//
//  GlobalMethods.swift
//  Denmark
//
//  Created by InexTure on 18/01/18.
//  Copyright © 2018 InexTure. All rights reserved.
//

import UIKit
import Alamofire
import SystemConfiguration
import SVProgressHUD
import AlamofireJsonToObjects

enum APIPath : String
{
    case login = "login"
    case registration = "registration"
    case getjobcategory = "getjobcategory"
    case loginwithfacebook = "loginwithfacebook"
}

class GlobalMethods: NSObject {

   
    static let WEB_SERVICE_BASE_URL  = "http://34.234.173.87:81/api/"
    
    static var deviceToken = ""
    var request: Alamofire.Request?
    static var checkUser_active = ""
    
    
    func callWebService(apiUrl : String,parameter: AnyObject!,  completionHandler:@escaping (AnyObject, NSError?)->()) ->()
    {
        if currentReachabilityStatus != .notReachable
        {
            
            let strAPIPath = GlobalMethods.WEB_SERVICE_BASE_URL + apiUrl
            
            print(strAPIPath)
            print(parameter)
            request = Alamofire.request(strAPIPath, method: .post, parameters: parameter as? Parameters, encoding: JSONEncoding.default, headers: nil).responseJSON { (response:DataResponse<Any>) in
                
                if self.currentReachabilityStatus != .notReachable
                {
                     if response.result.value == nil
                    {
                        let JSONError = response.result.error
                        let JSON = response.result.value
                        
                        completionHandler(JSON as AnyObject, JSONError as NSError?)
                    }
                    else
                    {
                        let JSON = response.result.value! as! NSDictionary
                        let JSONError = response.result.error
                        
                        completionHandler(JSON as AnyObject, JSONError as NSError?)
                    }
                }
                else
                {
                    showAlert(popUpMessage.someWrong.rawValue)
                }
            }
        }
        else
        {
            showAlert(popUpMessage.someWrong.rawValue)
        }
    }
    
    
    
    func GETcallWebService(apiUrl : String,parameter: AnyObject!,  completionHandler:@escaping (AnyObject, NSError?)->()) ->()
    {
        if currentReachabilityStatus != .notReachable
        {
            
            let strAPIPath = GlobalMethods.WEB_SERVICE_BASE_URL + apiUrl
            
            
            print(strAPIPath)
            print(parameter)
            request = Alamofire.request(strAPIPath, method: .get, parameters: parameter as? Parameters, encoding: JSONEncoding.default, headers: nil).responseJSON { (response:DataResponse<Any>) in
                
                if self.currentReachabilityStatus != .notReachable
                {
                    if response.result.value == nil
                    {
                        let JSONError = response.result.error
                        let JSON = response.result.value
                        completionHandler(JSON as AnyObject, JSONError as NSError?)
                    }
                    else
                    {
                        let JSON = response.result.value! as! NSDictionary
                        let JSONError = response.result.error
                        completionHandler(JSON as AnyObject, JSONError as NSError?)
                    }
                }
                else
                {
                    showAlert(popUpMessage.someWrong.rawValue)
                }
            }
        }
        else
        {
            showAlert(popUpMessage.someWrong.rawValue)
        }
    }
    
    //MARK: Stop All Services
    
    func StopWebService()
    {
        self.request?.cancel()
    }
    
    //MARK: User Default Method
    
    func setUserDefaultDictionary(ObjectToSave : AnyObject?  , KeyToSave : String)
    {
        let defaults = UserDefaults.standard
        
        if (ObjectToSave != nil)
        {
            defaults.set(ObjectToSave, forKey: KeyToSave)
        }
        
        UserDefaults.standard.synchronize()
    }
    
    func imageIsNull(imageName : UIImage)-> Bool
    {
        let size = CGSize(width: 0, height: 0)
        if (imageName.size.width == size.width)
        {
            return true
        }
        else
        {
            return false
        }
    }
    
    func setUserDefault(ObjectToSave : AnyObject?  , KeyToSave : String)
    {
        let defaults = UserDefaults.standard
        
        if (ObjectToSave != nil)
        {
            defaults.set(ObjectToSave!, forKey: KeyToSave)
        }
        
        UserDefaults.standard.synchronize()
    }

    func getUserDefaultDictionaryValue(KeyToReturnValye : String) -> NSDictionary?
    {
        let defaults = UserDefaults.standard
        let TempData = defaults.object(forKey: KeyToReturnValye)
        
        if TempData != nil
        {
            //let data = defaults.data(forKey: KeyToReturnValye)
            let dictonary = defaults.object(forKey: KeyToReturnValye) as! NSDictionary
            //let data : Data = defaults.object(forKey: KeyToReturnValye) as! Data
           // let unarchivedDictionary:NSDictionary = NSKeyedUnarchiver.unarchiveObject(with: data!) as! NSDictionary
            return dictonary
        }
        return nil
    }
    
    func getDecodeUserDefaultDictionaryValue(KeyToReturnValye : String) -> NSDictionary?
    {
        let defaults = UserDefaults.standard
        let TempData = defaults.object(forKey: KeyToReturnValye)
        
        if TempData != nil
        {
            //let data = defaults.data(forKey: KeyToReturnValye)
            let data : Data = defaults.object(forKey: KeyToReturnValye) as! Data
            let unarchivedDictionary:NSDictionary = NSKeyedUnarchiver.unarchiveObject(with: data) as! NSDictionary
            return unarchivedDictionary
        }
        return nil
    }
    
    func checkErrorType(error:NSError) -> Bool
    {
        if error.code == -1005
        {
            return true
        }
        
        return false
    }
    
    
    func getUserDefault(KeyToReturnValye : String) -> AnyObject?
    {
        let defaults = UserDefaults.standard
        
        if let name = defaults.value(forKey: KeyToReturnValye)
        {
            return name as AnyObject?
        }
        
        return nil
    }
    

    func removeuserDefaultKey(string:String)
    {
        let defaults = UserDefaults.standard
        
        defaults.removeObject(forKey: string)
    }
    
    //MARK: Get Attribute String
    
    func checkUserDefaultKey(kUsernameKey: String) -> Bool
    {
        return UserDefaults.standard.object(forKey: kUsernameKey) != nil
    }
    
    
    
    //MARK: Check Dictionary Key Exits or not
    
    func checkDictionaryKeyExits(key: String, response: NSDictionary) -> Bool
    {
        if response.value(forKey: key) != nil
        {
            return true
        }
        return false
    }
    
    //MARK: AlertView Display
    
    func ShowAlertDisplay(titleObj:String, messageObj:String, viewcontrolelr:UIViewController)
    {
        let AlertObj = UIAlertController.init(title:titleObj, message: messageObj, preferredStyle: UIAlertControllerStyle.alert)
        
        AlertObj.addAction(UIAlertAction.init(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
        
        viewcontrolelr.navigationController?.present(AlertObj, animated: true, completion: nil)
    }
    
    
    
//    func addBoldText(fullString: NSString, boldPartsOfString: Array<NSString>, font: UIFont!, boldFont: UIFont!) -> NSAttributedString {
//        let nonBoldFontAttribute = [NSFontAttributeName:font!]
//        let boldFontAttribute = [NSFontAttributeName:boldFont!]
//        let boldString = NSMutableAttributedString(string: fullString as String, attributes:nonBoldFontAttribute)
//        for i in 0 ..< boldPartsOfString.count {
//            boldString.addAttributes(boldFontAttribute, range: fullString.range(of: boldPartsOfString[i] as String))
//        }
//        return boldString
//    }
    
    func isConnectedToNetwork() -> Bool {
        
        var zeroAddress = sockaddr_in(sin_len: 0, sin_family: 0, sin_port: 0, sin_addr: in_addr(s_addr: 0), sin_zero: (0, 0, 0, 0, 0, 0, 0, 0))
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        
        var flags: SCNetworkReachabilityFlags = SCNetworkReachabilityFlags(rawValue: 0)
        if SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) == false {
            return false
        }
        
        let isReachable = flags == .reachable
        let needsConnection = flags == .connectionRequired
       
        
        return isReachable && !needsConnection
    }

    
}

extension UIApplication {
    class func topViewController(base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let nav = base as? UINavigationController {
            return topViewController(base: nav.visibleViewController)
        }
        if let tab = base as? UITabBarController {
            if let selected = tab.selectedViewController {
                return topViewController(base: selected)
            }
        }
        if let presented = base?.presentedViewController {
            return topViewController(base: presented)
        }
        return base
    }
}




extension UILabel
{
    var optimalHeight : CGFloat
        {
        get
        {
            let label = UILabel(frame:CGRect(x: 0, y: 0, width: self.frame.width, height: CGFloat.greatestFiniteMagnitude ))
            label.numberOfLines = 0
            label.lineBreakMode = self.lineBreakMode
            label.font = self.font
            label.text = self.text
            
            label.sizeToFit()
            return label.frame.height
        }
    }
}

extension UIColor {
    convenience init(hexString: String)
    {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt32()
        Scanner(string: hex).scanHexInt32(&int)
        let a, r, g, b: UInt32
        switch hex.characters.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
}


extension String {
    
    func slice(from: String, to: String) -> String? {
        
        return (range(of: from)?.upperBound).flatMap { substringFrom in
            (range(of: to, range: substringFrom..<endIndex)?.lowerBound).map { substringTo in
                substring(with: substringFrom..<substringTo)
            }
        }
    }
}

protocol Utilities {
}


extension NSObject:Utilities{
    
    
    enum ReachabilityStatus {
        case notReachable
        case reachableViaWWAN
        case reachableViaWiFi
    }
    
    var currentReachabilityStatus: ReachabilityStatus {
        
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout<sockaddr_in>.size)
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        guard let defaultRouteReachability = withUnsafePointer(to: &zeroAddress, {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
                SCNetworkReachabilityCreateWithAddress(nil, $0)
            }
        }) else {
            return .notReachable
        }
        
        var flags: SCNetworkReachabilityFlags = []
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) {
            return .notReachable
        }
        
        if flags.contains(.reachable) == false {
            // The target host is not reachable.
            return .notReachable
        }
        else if flags.contains(.isWWAN) == true {
            // WWAN connections are OK if the calling application is using the CFNetwork APIs.
            return .reachableViaWWAN
        }
        else if flags.contains(.connectionRequired) == false {
            // If the target host is reachable and no connection is required then we'll assume that you're on Wi-Fi...
            return .reachableViaWiFi
        }
        else if (flags.contains(.connectionOnDemand) == true || flags.contains(.connectionOnTraffic) == true) && flags.contains(.interventionRequired) == false {
            // The connection is on-demand (or on-traffic) if the calling application is using the CFSocketStream or higher APIs and no [user] intervention is needed
            return .reachableViaWiFi
        }
        else {
            return .notReachable
        }
    }
    
}
