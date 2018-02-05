//
//  Contants.swift
//  Denmark
//
//  Created by Lokesh Dudhat on 1/30/18.
//  Copyright © 2018 InexTure. All rights reserved.
//

import UIKit


let appDelegate = UIApplication.shared.delegate as! AppDelegate
let mainStory = UIStoryboard(name: "Main", bundle: nil)
var userType: UserType = .none
let appWidth = UIScreen.main.bounds.size.width
let appHeight = UIScreen.main.bounds.size.height
let BASE_URL  = "http://34.234.173.87:81/api/"

let global = GlobalMethods()
var userCategory = EmployeeCategory()
var userModel = UserModal()
var LoginUserModal = UserLogin()

let themeColor = UIColor(red: 84.0/255.0, green: 183.0/255.0, blue: 183.0/255.0, alpha: 1.0)
enum UserType {
    case none
    case employee
    case employer
}

extension UIViewController {
    func setupBack() {
        let backButtonImage = UIImage(named: "ic_back")?.withRenderingMode(.alwaysOriginal)
        self.navigationController?.navigationBar.backIndicatorImage = backButtonImage
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = backButtonImage
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.plain, target: nil, action: nil)
    }
}
enum popUpMessage : String {
    case someWrong          = "Something went wrong. Please try again later"
    case emptyString        = "Please fill all the fields"
    case emptyFirstName     = "First name should not be blank"
    case emptyLastName      = "Last name should not be blank"
    case PasswordValid      = "The password must be between 6 to 32 characters"
    case MobileValid        = "Please enter valid mobile number"
    case UserEmailValid     = "Please enter valid  email"
    case emptyEmailId       = "Please enter email"
    case optionSelect       = "Please specify the product's option(s)"
    case addressSelect      = "Select Shipping and Billing Address"
    case shippingTypeSelect = "Select shipping method to continue"
    case paymentTypeSelect  = "Select payment method to continue"
    case passwordNotMatch   = "New password and confirm password not matched"
    case emptyName          = "Name should not be blank"
    case emptyEmail          = "Email should not be blank"
    case emptyAddress        = "Address should not be blank"
    case emptyBirthdate       = "Birthdate should not be blank"
    case emptyAge             = "Age should not be blank"
    case emptyContact          = "Contact No. should not be blank"
    case emptyCategory          = "Category should not be blank"
    case emptyPassword          = "Password should not be blank"
    case emptyConfirmPassword   = "Confirm Password should not be blank"
    case SamePassword          = "password and Confirm password are not same"
    case uploadImageError        = "Please select user Profile Image"
    case emptyCVR        = "CVR should not be blank"
    case emptyCPR        = "CPR should not be blank"

}
func showAlert(_ message: String, position: HRToastPosition = HRToastPosition.Default)
{
    if message.length > 0 {
        DispatchQueue.main.async(execute: {
            appDelegate.window!.makeToast(message: message , duration: 2, position: position)
        })
    }
}
