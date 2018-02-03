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
    
    func registerWithParameters () {
        if checkInternet() == false {
            showAlert(popUpMessage.someWrong.rawValue)
            return
        }
        view.endEditing(true)
      
        /*
        {
            "name": "Dipesh Gangani",
            "role_id": "2",
            "email": "test@test.com",
            "password": "123456",
            "address": "C-601 Ganesh Mardian",
            "birthdate": "2005-01-02",
            "cvr": "test",
            "cpr": "",
            "age_for_handicapped": "",
            "is_company": "",
            "contact_no": "9974199409",
            "image": "multipart",
            "address_latitude": "",
            "address_longitude": "",
            "facebook_id": "",
            "facebook_token": "",
            "social_provider":"1",
            "is_verified" :0
        }
        */
        
        var parameters = [String:Any]()
        if role_Id == "2"{
             parameters =  ["name":"\(txtName.text!)","role_id":role_Id,"email":"\(txtEmail.text!)","password":"\(txtPassword.text!)","address":"\(txtAddress.text!)","birthdate":"\(txtDate.text!)","cpr":cpr,"age_for_handicapped":age_handicapped,"is_company":is_company,"contact_no":"\(txtContact.text!)","address_latitude":user_lat,"address_longitude":user_lng,"facebook_id":facebook_Id,"facebook_token":facebook_Token,"social_provider":socialProvider,"is_verified":is_verified] as [String : Any]
            
        }else{
             parameters =  ["name":"\(txtName.text!)","role_id":role_Id,"email":"\(txtEmail.text!)","password":"\(txtPassword.text!)","address":"\(txtAddress.text!)","birthdate":"\(txtDate.text!)","cvr":CVR,"cpr":cpr,"age_for_handicapped":age_handicapped,"is_company":is_company,"contact_no":"\(txtContact.text!)","address_latitude":user_lat,"address_longitude":user_lng,"facebook_id":facebook_Id,"facebook_token":facebook_Token,"social_provider":socialProvider,"is_verified":is_verified] as [String : Any]
        }
        
        
        print("parameter is",parameters)
        
//
//        1) Role
//        Value : 2 - Employee,  3 = Employer
//
//        Note
//        If role id is 2 then do not pass cvr field.
//
//        2) Social Provider
//        Value : 1 = Simple,  2 = Facebook
//
//        Note
//        If Social Provider is 1 then pass blank/null facebook_id and facebook_token fields.
//
//        If you get email from facebook then pass is_verified = 1 else 0.
//
//        is_company : 0/1
        
        
        let imgData = UIImagePNGRepresentation(self.imgProfileUser.image!)!
        
        
        print("imgData is",imgData)
        
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            multipartFormData.append(UIImagePNGRepresentation(self.imgProfileUser.image!)!, withName: "image", fileName: "swift_file.jpeg", mimeType: "image/jpeg")
            for (key, value) in parameters {
                multipartFormData.append((value as AnyObject).data(using: String.Encoding.utf8.rawValue)!, withName: key)
            }
        }, to:BASE_URL)
        { (result) in
            switch result {
            case .success(let upload, _, _):
                
                upload.uploadProgress(closure: { (progress) in
                    print("Progress is",progress)
                    
                })
                
                upload.responseJSON { response in
                    print("uploaded image response is",response)
                    print("response.result is",response.result)
                }
                
            case .failure(let encodingError):
                print("encodingError.description",encodingError.localizedDescription)
                break
            }
        }
    }
}

