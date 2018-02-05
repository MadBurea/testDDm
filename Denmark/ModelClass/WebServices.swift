//
//  WebServices.swift
//  SweetNSweets
//
//  Created by APPLE on 3/27/17.
//  Copyright © 2017 Inexture. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import SVProgressHUD

extension EmployeeRegVC {
    
    func getJobCategory (){
        
        if checkInternet() == false {
            showAlert(popUpMessage.someWrong.rawValue)
            return
        }
        view.endEditing(true)
        
        SVProgressHUD.show()
        
       let strAPIPath = GlobalMethods.WEB_SERVICE_BASE_URL + APIPath.getjobcategory.rawValue
        
        Alamofire.request(strAPIPath,method:.get , parameters: nil, headers: nil)
            .responseObject { (response: DataResponse<EmployeeCategory>) in
             
                SVProgressHUD.dismiss()

                if response.result.value != nil {
                    
                    let responseValue = response.result.value
                    userCategory = responseValue!
                    
                    if userCategory.status == "1" {
                        let userDict = responseValue!.toJsonData()
                        global.setUserDefault(ObjectToSave: userDict as AnyObject, KeyToSave: kUserCategory)
                        
                        self.txtDriver.text = userCategory.data[0].name
                        self.job_category_id = userCategory.data[0].id

                    }else{
                        showAlert(popUpMessage.someWrong.rawValue)
                    }
                }
            }
            .responseJSON { response in
                switch response.result {
                case .success:
                    break
                case .failure(let error):
                    SVProgressHUD.dismiss()
                    showAlert(error.localizedDescription)
                    break
            }
        }
    }
    
    
    func registerWithParameter() {
        
        if checkInternet() == false {
            showAlert(popUpMessage.someWrong.rawValue)
            return
        }
        view.endEditing(true)
        
        SVProgressHUD.show()
        
        
        let strAPIPath = GlobalMethods.WEB_SERVICE_BASE_URL + APIPath.registration.rawValue
        if is_company == "0" {
            cpr =  txtCPR.text!
        }
        if is_company == "1" {
            CVR =  txtCPR.text!
        }
    
   let parameters =  ["name":"\(txtName.text!)","role_id":role_Id,"email":"\(txtEmail.text!)","password":"\(txtPassword.text!)","address":"\(txtAddress.text!)","birthdate":"\(txtDate.text!)","cvr":CVR,"cpr":cpr,"age_for_handicapped":age_handicapped,"is_company":is_company,"contact_no":"\(txtContact.text!)","address_latitude":user_lat,"address_longitude":user_lng,"facebook_id":facebook_Id,"facebook_token":facebook_Token,"social_provider":socialProvider,"is_verified":is_verified,"job_category_id":job_category_id] as [String : Any]

    let imgData = UIImagePNGRepresentation(self.imgProfileUser.image!)

        Alamofire.upload(multipartFormData: { (multipartFormData) in
            multipartFormData.append(imgData!, withName: "image", fileName: "swift_file.jpeg", mimeType: "image/jpeg")
            for (key, value) in parameters {
                multipartFormData.append((value as AnyObject).data(using: String.Encoding.utf8.rawValue)!, withName: key)
            }
        }, to:strAPIPath)
        { (result) in
             switch result {
            case .success(let upload, _, _):

                upload.responseObject { (response: DataResponse<UserModal>) in

                    SVProgressHUD.dismiss()

                    if response.result.value != nil {

                        let responseValue = response.result.value
                        userModel = responseValue!

                        showAlert(userModel.message)

                        if userModel.status == "1" {
                            let userDict = responseValue!.toJsonData()
                            global.setUserDefault(ObjectToSave: userDict as AnyObject, KeyToSave: kUserModel)
                            
                            self.navigationController?.popViewController(animated: true)
                        }
                    }
                }
                upload.responseJSON { response in
                    switch response.result {
                    case .success:
                        SVProgressHUD.dismiss()
                        break
                    case .failure(let error):
                        SVProgressHUD.dismiss()
                        showAlert(error.localizedDescription)
                        break
                    }
                }
            case .failure(let encodingError):
                SVProgressHUD.dismiss()
                showAlert(encodingError.localizedDescription)
            }
        }
    }

}

extension LoginVC {
    
    func LoginWithParameter()  {
        
        if checkInternet() == false {
            showAlert(popUpMessage.someWrong.rawValue)
            return
        }
        view.endEditing(true)
        
        SVProgressHUD.show()
        
        let deviceID = UIDevice.current.identifierForVendor?.uuidString

        let param =  ["email":"\(txtEmail.text!)","device_type":"2","push_token":"1","device_id":deviceID,"password":"\(txtPassword.text!)"] as [String : Any]
        
        let strAPIPath = GlobalMethods.WEB_SERVICE_BASE_URL + APIPath.login.rawValue
        
        Alamofire.request(strAPIPath,method:.post , parameters: param as? Parameters, headers: nil)
            .responseObject { (response: DataResponse<UserLogin>) in
                
                SVProgressHUD.dismiss()
                
                if response.result.value != nil {
                    
                    let responseValue = response.result.value
                    LoginUserModal = responseValue!
                    
                    showAlert(LoginUserModal.message)

                    if LoginUserModal.status == "1" {
                        let userDict = responseValue!.toJsonData()
                        global.setUserDefault(ObjectToSave: userDict as AnyObject, KeyToSave: kLoginUser)
                    }
                }
            }
            .responseJSON { response in
                switch response.result {
                case .success:
                    break
                case .failure(let error):
                    SVProgressHUD.dismiss()
                    showAlert(error.localizedDescription)
                    break
                }
        }
        
    }
}




