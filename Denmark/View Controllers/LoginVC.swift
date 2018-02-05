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

class LoginVC: UIViewController {

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
    var facebook_Id = ""
    var facebook_Token = ""
    var is_verified = ""
    var socialProvider = ""
    var UserName = ""
    var UserEmail = ""
    var UserImageURL = ""

    
    //MARK: - UIView Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.setUpScreen()
        
        if let userDetail = UserDefaults.standard.object(forKey: kLoginUser) as? Data {
            LoginUserModal = UserLogin(data: userDetail)
            
//            print("Login data is",LoginUserModal.status)
//            print("Login data is",LoginUserModal.message)
//            print("Login data is",LoginUserModal.data)
//            print("Login data is",LoginUserModal.data[0].image_orginial_url)
//            print("Login data is",LoginUserModal.data[0].image_thumb_url)

        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
                showAlert("An error occured. Plese try later.")

            case .cancelled:
                showAlert("User cancelled facebook login.")

            case .success:
                
                self.getUserrInfo(completion: { (userInfo, error) in
                    
                    if error != nil {
                        print(error!.localizedDescription)
                        
                    }
                    else {
                        print("userInfo",userInfo!)
                        
                        if let userInfo = userInfo, let name = userInfo["name"], let userId = userInfo["id"], let email = userInfo["email"] , let _ = userInfo["gender"] {
                            
                            self.facebook_Id = "\(userId)"
                            self.facebook_Token = AccessToken.current!.authenticationToken
                            self.facebook_Token = AccessToken.current!.authenticationToken
                            self.is_verified = "2"
                            self.socialProvider = "2"
                            self.UserName = "\(name)"
                            self.UserEmail = "\(email)"

                            
                            if let imageURL = ((userInfo["picture"] as? [String: Any])?["data"] as? [String: Any])?["url"] as? String {
                                //Download image from imageURL
                                self.UserImageURL = imageURL

                            }
                            
                            self.LoginWithfacebook()
                           
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
        /*
        if userType == .employee, let controller = mainStory.instantiateViewController(withIdentifier: "NavEmployeeVC") as? NavEmployeeVC {
            appDelegate.window?.rootViewController = controller
        }
        else if userType == .employer, let controller = mainStory.instantiateViewController(withIdentifier: "NavEmployerVC") as? NavEmployerVC {
            appDelegate.window?.rootViewController = controller
        }
 */
        if validation() {
            self.LoginWithParameter()
        }
    }
    
    @IBAction func btnSignupAct(_ sender: Any)
    {
        let signupObj = self.storyboard?.instantiateViewController(withIdentifier: "EmployeeRegVC") as! EmployeeRegVC
        self.navigationController?.pushViewController(signupObj, animated: true)
    }
}


extension LoginVC: UITextFieldDelegate {
    
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
    
    func validation() -> Bool
    {
        if txtEmail.text?.trim.length == 0 {
            showAlert(popUpMessage.emptyEmail.rawValue)
            return false
        }
        else if txtEmail.text!.trim.length < 3 || txtEmail.text!.trim.length > 255 {
            showAlert(popUpMessage.UserEmailValid.rawValue)
            return false
        }
        else if !(txtEmail.text?.isEmail)!
        {
            showAlert(popUpMessage.UserEmailValid.rawValue)
            return false
        }
        else if txtPassword.text?.trim.length == 0 {
            showAlert(popUpMessage.emptyPassword.rawValue)
            return false
        }
        else{
            return true
        }
    }
}
