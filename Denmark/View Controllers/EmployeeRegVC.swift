//
//  EmployeeRegVC.swift
//  Denmark
//
//  Created by InexTure on 18/01/18.
//  Copyright © 2018 InexTure. All rights reserved.
//

import UIKit
import GooglePlaces
import GooglePlacePicker

class EmployeeRegVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

   
    /* OUTLETS */
    
    @IBOutlet weak var imgProfileUser: UIImageView!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var btnSignin: UIButton!
    @IBOutlet weak var lblAlready: UILabel!
    @IBOutlet weak var txtConfirmPassword: UITextField!
    @IBOutlet weak var btnSignUp: UIButton!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtDate: UITextField!
    @IBOutlet weak var txtAddress: UITextField!
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var lblScreenDesc: UILabel!
    @IBOutlet weak var txtContact: UITextField!

    @IBOutlet weak var btn_IsCompany: UIButton!
    @IBOutlet weak var txtCPR: LDTextField!
    @IBOutlet weak var txtDriver: LDTextField!
    @IBOutlet weak var driverViewHeightConstraints: NSLayoutConstraint!
    @IBOutlet weak var CPRViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var companyViewHeightConstraints: NSLayoutConstraint!
    @IBOutlet weak var driverView: UIView!
    @IBOutlet weak var companyView: UIView!
    @IBOutlet weak var cprView: UIView!
    
    var placesClient: GMSPlacesClient!
    var CVR = ""
    var role_Id = ""
    var age_handicapped = ""
    var user_lat = ""
    var user_lng = ""
    var facebook_Id = ""
    var facebook_Token = ""
    var socialProvider = ""
    var is_company = ""
    var is_verified = ""
    var cpr = ""

    var imagePickerControllerObj:UIImagePickerController!

    
    //MARK: - UIView Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        placesClient = GMSPlacesClient.shared()
        
        imgProfileUser.backgroundColor = UIColor.black
        imgProfileUser.layer.cornerRadius = 45
        imgProfileUser.layer.masksToBounds = true
        
        
        let tapGesture = UITapGestureRecognizer()
        tapGesture.addTarget(self, action: #selector(self.OpenImagePicker))
        imgProfileUser.isUserInteractionEnabled = true
        imgProfileUser.addGestureRecognizer(tapGesture)
        
        imagePickerControllerObj = UIImagePickerController()
        imagePickerControllerObj.delegate = self
        imagePickerControllerObj.sourceType = .photoLibrary
        
        if userType == .employee {
            CPRViewHeightConstraint.constant = 0
            companyViewHeightConstraints.constant = 0
            
            self.companyView.isHidden = true
            self.cprView.isHidden = true
            role_Id = "2"
        }else{
            driverViewHeightConstraints.constant = 0
            self.driverView.isHidden = true
            role_Id = "3"
            is_company = "0"
        }
        
        socialProvider = "1"
        is_verified = "0"
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func getCurrentPlace(_ sender: UIButton) {
        let center = CLLocationCoordinate2D(latitude: 37.788204, longitude: -122.411937)
        let northEast = CLLocationCoordinate2D(latitude: center.latitude + 0.001, longitude: center.longitude + 0.001)
        let southWest = CLLocationCoordinate2D(latitude: center.latitude - 0.001, longitude: center.longitude - 0.001)
        let viewport = GMSCoordinateBounds(coordinate: northEast, coordinate: southWest)
        let config = GMSPlacePickerConfig(viewport: viewport)
        let placePicker = GMSPlacePicker(config: config)
        
        placePicker.pickPlace(callback: {(place, error) -> Void in
            if let error = error {
                print("Pick Place error: \(error.localizedDescription)")
                return
            }
            
            if let place = place {
               print(place.name)
               
            } else {
               print("No place selected")
            }
        })
    }
        
    //MARK: - UIView Action
    @IBAction func btnAddressAct(_ sender: Any)
    {
        let autocompleteController = GMSAutocompleteViewController()
        autocompleteController.delegate = self
        present(autocompleteController, animated: true, completion: nil)
    }
    
    @IBAction func btnBackAct(_ sender: Any)
    {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func isCompanyClicked(_ sender: Any) {
        
        if btn_IsCompany.isSelected {
            btn_IsCompany.isSelected = false
            txtDate.placeholder = "Birthdate"
            txtCPR.placeholder = "CPR"
            is_company = "0"
        }else{
            btn_IsCompany.isSelected = true
            txtDate.placeholder = "Age"
            txtCPR.placeholder = "CVR"
            is_company = "1"
        }
    }
    
    @IBAction func txtDateEditAct(_ sender: UITextField)
    {
        let datePickerView:UIDatePicker = UIDatePicker()
        datePickerView.datePickerMode = UIDatePickerMode.date
        sender.inputView = datePickerView
        datePickerView.addTarget(self, action: #selector(EmployeeRegVC.datePickerValueChanged), for: UIControlEvents.valueChanged)
    }
    
    @objc func datePickerValueChanged(sender:UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        dateFormatter.dateFormat = "yyyy-MM-dd"
        txtDate.text = dateFormatter.string(from: sender.date)
    }
    
    @IBAction func btnSignupAct(_ sender: Any) {
        self.registerWithParameters()
    }
    @IBAction func btnSigninAct(_ sender: Any) {
    }
    
    @objc func OpenImagePicker()
    {
        imagePickerControllerObj.allowsEditing = false
        present(imagePickerControllerObj, animated: true, completion: nil)
    }
    
    //MARK: Image PickerController Delegate
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any])
    {
        let imageName = info[UIImagePickerControllerOriginalImage] as! UIImage
        imgProfileUser.image = imageName
        imagePickerControllerObj.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController)
    {
        imagePickerControllerObj.dismiss(animated: true, completion: nil)
    }
}

extension EmployeeRegVC: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if txtEmail == textField {
            if (string.isEmailString ) {
                let maxLength = 255
                let currentString: NSString = textField.text! as NSString
                let newString: NSString =
                    currentString.replacingCharacters(in: range, with: string) as NSString
                return newString.length <= maxLength
            }
            else {
                return false
            }
        }
        else if txtPassword == textField {
            let maxLength = 32
            let currentString: NSString = textField.text! as NSString
            let newString: NSString =
                currentString.replacingCharacters(in: range, with: string) as NSString
            return newString.length <= maxLength
        }
        else {
            return true
        }
    }
    func validation() -> Bool
    {
        if txtEmail.text!.trim.length < 3 || txtEmail.text!.trim.length > 255 {
            showAlert(popUpMessage.UserEmailValid.rawValue)
            return false
        }
        else if (txtPassword.text!.trim == "") {
            showAlert(popUpMessage.emptyPassword.rawValue)
            return false
        }
        else if (txtPassword.text!.trim.length < 6 || txtPassword.text!.trim.length > 16){
            showAlert(popUpMessage.PasswordValid.rawValue)
            return false
        }
        else{
            return true
        }
    }
}

extension EmployeeRegVC: GMSAutocompleteViewControllerDelegate {
    
    // Handle the user's selection.
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
       // print("Place name: \(place.name)")
        
        txtAddress.text = place.name
        user_lat = "\(place.coordinate.latitude)"
        user_lng = "\(place.coordinate.longitude)"

      //  print("Place address: \(place.formattedAddress)")
      //  print("Place attributions: \(place.attributions)")
        
   //     print("Place lat: \(place.coordinate.latitude)")
     //   print("Place lng: \(place.coordinate.longitude)")

        dismiss(animated: true, completion: nil)
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        // TODO: handle the error.
        print("Error: ", error.localizedDescription)
    }
    
    // User canceled the operation.
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    // Turn the network activity indicator on and off again.
    func didRequestAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    func didUpdateAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
    
}
