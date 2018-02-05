//
//  AllModalClassResponse.swift
//  ProTeen
//
//  Created by test on 1/4/18.
//  Copyright © 2018 Mac. All rights reserved.
//

import Foundation
import UIKit
import AlamofireJsonToObjects


let kUserCategory = "userJobCategory"
let kUserModel = "userModel"
let kLoginUser = "LoginUser"

/***** Employee Category *****/

class EmployeeCategory: EVNetworkingObject {
    var status = ""
    var data = [EmployeeCatgoryData]()

    class func clearUser() {
        let defaults: UserDefaults = UserDefaults.standard
        defaults.removeObject(forKey: kUserCategory)
        defaults.synchronize()
    }
}
class EmployeeCatgoryData: EVNetworkingObject{
    var created_at = ""
    var id = ""
    var name = ""
    var updated_at = ""
    var status = ""
}


/***** User Model *****/

class UserModal: EVNetworkingObject {
    var status = ""
    var message = ""
    
    var data = [UserModalData]()
    
    class func clearUser() {
        let defaults: UserDefaults = UserDefaults.standard
        defaults.removeObject(forKey: kUserCategory)
        defaults.synchronize()
    }
}
class UserModalData: EVNetworkingObject {
    var name = ""
    var email = ""
    var contact_no = ""
    var image = ""
    var address_latitude = ""
    var address_longitude = ""
    var current_latitude = ""
    var current_longitude = ""
    var address = ""
    var birthdate = ""
    var cpr = ""
    var cvr = ""
    var is_company = ""
    var age_for_handicapped = ""
    var job_category_id = ""
    var role_id = ""
    var facebook_id = ""
    var facebook_token = ""
    var is_verified = ""
    var status = ""
    var updated_at = ""
    var created_at = ""
    var id = ""
}

/***** User Login Data *****/

class UserLogin: EVNetworkingObject {
    var status = ""
    var message = ""
    
    var data = [UserLoginData]()
    
    class func clearUser() {
        let defaults: UserDefaults = UserDefaults.standard
        defaults.removeObject(forKey: kLoginUser)
        defaults.synchronize()
    }
}


class UserFacebookLogin: EVNetworkingObject {
    var status = ""
    var message = ""
    var is_registered = ""

    var data = [UserLoginData]()
    
    class func clearUser() {
        let defaults: UserDefaults = UserDefaults.standard
        defaults.removeObject(forKey: kLoginUser)
        defaults.synchronize()
    }
}

class UserLoginData: EVNetworkingObject {
    var role_id = ""
    var name = ""
    var email = ""
    var contact_no = ""
    var image = ""
    var image_orginial_url = ""
    var image_thumb_url = ""
    var facebook_id = ""
    var facebook_token = ""
    var address_latitude = ""
    var address_longitude = ""
    var ready_for_service = ""
    var social_provider = ""
    var cpr = ""
    var address = ""
    var birthdate = ""
    var cvr = ""
    var is_company = ""
    var age_for_handicapped = ""
    var token = ""
}






