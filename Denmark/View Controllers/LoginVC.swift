//
//  LoginVC.swift
//  Denmark
//
//  Created by InexTure on 17/01/18.
//  Copyright © 2018 InexTure. All rights reserved.
//

import UIKit
import FacebookLogin
import FacebookCore
import SVProgressHUD

class LoginVC: UIViewController,UITextFieldDelegate {

    @IBOutlet weak var lblWelcome: UILabel!
    
    @IBOutlet weak var lblLoginWithFB: UILabel!
    
    @IBOutlet weak var lblOr: UILabel!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    
    @IBOutlet weak var btnForgot: UIButton!
    
    @IBOutlet weak var btnSignup: UIButton!
    @IBOutlet weak var lblDontAcc: UILabel!
    @IBOutlet weak var btnLogin: UIButton!
    
    var isFromEmployee: Bool!
    
    //MARK: - UIView Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.setUpScreen()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - UITextField Method
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        if txtEmail == textField {
            textField.resignFirstResponder()
            txtPassword.becomeFirstResponder()
        }
        else{
            textField.resignFirstResponder()
        }
        return true
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if txtEmail.isFirstResponder {
            if (txtEmail.textInputMode?.primaryLanguage == "emoji") || !((txtEmail.textInputMode?.primaryLanguage) != nil) {
                    return false
                }
        }
        return true
    }
    //MARK: - UIView Method
    func setUpScreen()
    {
        lblWelcome.text = kWelComeBack
        lblLoginWithFB.text = kLoginWithFB
        lblOr.text = kOr
        
        txtEmail.attributedPlaceholder = NSAttributedString(string: kEmail,attributes: [NSAttributedStringKey.foregroundColor: themeColor])
        txtPassword.attributedPlaceholder = NSAttributedString(string: kPassword,attributes: [NSAttributedStringKey.foregroundColor: themeColor])
        btnForgot.setTitle(kForgot, for: .normal)
        btnLogin.setTitle(kLogin, for: .normal)
        lblDontAcc.text = kDontAccountMsg
        btnSignup.setTitle(kSignUpNow, for: .normal)
    }
    //MARK: - UIView Action
    @IBAction func btnBackAct(_ sender: Any)
    {
        self.navigationController?.popViewController(animated: true)
    }
    // Facebook - Get User Information
    func getUserrInfo(completion: @escaping ([String: Any]?,Error?) -> Void) {
        
        let req = GraphRequest(graphPath: "me", parameters: ["fields":"email,name,picture,first_name,last_name,gender"])
        
        req.start {response , result in
            
            switch result {
                
            case .failed(let error):
                completion(nil, error)
                
            case .success(let graphResponse):
                completion(graphResponse.dictionaryValue, nil)
                
            }
        }
    }
    
    @IBAction func btnFBLoginAct(_ sender: Any) {
        
        let loginManager = LoginManager()
        loginManager.logOut()
    
        loginManager.logIn(readPermissions:[.publicProfile,.email], viewController: self) { LoginResult in
            switch LoginResult {
                
            case .failed(let error):
                
                print(error.localizedDescription)
                // self.showAlertWith(message: "An error occured. Plese try later.")
                
            case .cancelled:
                print("User cancelled facebook login.")
                
            case .success:
                
                // self.showHud()
                
                self.getUserrInfo(completion: { (userInfo, error) in
                    
                    if error != nil {
                        print(error!.localizedDescription)
                        
                    }
                    else {
                        print("userInfo",userInfo!)
                        
                        if let userInfo = userInfo, let name = userInfo["name"], let userId = userInfo["id"], let email = userInfo["email"] , let gender = userInfo["gender"] {
                            print("\nid",userId)
                            print("name",name)
                            print("email",email)
                            print("gender",gender)
                        }
                        
                        print("FB token :- ",AccessToken.current!.authenticationToken)
                        
                    }
                })
            }
        }
    }
    
    @IBAction func btnForgotAct(_ sender: Any) {
       
       // SVProgressHUD.setDefaultStyle(SVProgressHUDStyle.custom);
//        SVProgressHUD.setDefaultMaskType(SVProgressHUDMaskType.black)
//        SVProgressHUD.show()
    }
    
    @IBAction func btnLoginAct(_ sender: Any)
    {
        if userType == .employee, let controller = mainStory.instantiateViewController(withIdentifier: "NavEmployeeVC") as? NavEmployeeVC {
            appDelegate.window?.rootViewController = controller
        }
        else if userType == .employer, let controller = mainStory.instantiateViewController(withIdentifier: "NavEmployerVC") as? NavEmployerVC {
            appDelegate.window?.rootViewController = controller
        }
        /*
        if (txtEmail.text?.isBlank)!
        {
            SVProgressHUD.showError(withStatus: kEmailReqMsg)
        }
        else if !(txtEmail.text?.isEmail)!
        {
            SVProgressHUD.showError(withStatus: kInvalidEmailMsg)
        }
        else if (txtPassword.text?.isBlank)!
        {
            SVProgressHUD.showError(withStatus: kPassReqMsg)
        }
        else
        {
            loginApi()
        }
         */
    }
    
    @IBAction func btnSignupAct(_ sender: Any)
    {
        let signupObj = self.storyboard?.instantiateViewController(withIdentifier: "EmployeeRegVC") as! EmployeeRegVC
        self.navigationController?.pushViewController(signupObj, animated: true)
    }
    //MARK: - Web Services Call
    func loginApi()
    {
        self.view.endEditing(true)
        SVProgressHUD.show()
        
        //print("FCM TOKEN : ",appdel.fcmToken)
        
        let global = GlobalMethods()
        let param =  ["email":"\(txtEmail.text!)","device_type":"1","push_token":"1","device_id":"12","password":"\(txtPassword.text!)"] as [String : Any]
        
        print("Sign In Parameter : ",param)
        
        global.callWebService(apiUrl: APIPath.login.rawValue, parameter: param as AnyObject!) { (Response:AnyObject, error:NSError?) in
            
            if error != nil
            {
                SVProgressHUD.showInfo(withStatus: kPleaseTryAgainMsg)
            }
            else
            {
                
                let dictResponse = Response as! NSDictionary
                print(dictResponse)
                let status = dictResponse.object(forKey: "status") as! String
                
                if Int(status) == 1
                {
                    
                    DispatchQueue.main.async(execute: {() -> Void in
                        
                        SVProgressHUD.showSuccess(withStatus: dictResponse.object(forKey: "message") as? String)
                    })
                    
                    let dataDict = dictResponse.object(forKey: "data") as! NSDictionary
                    
                    print(dataDict)
                    
                }
                else
                {
                      SVProgressHUD.showInfo(withStatus: dictResponse.object(forKey: "message") as! String!)
                }
            }
        }
    }
}
