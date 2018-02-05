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
import SDWebImage

class EmployeeRegVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate,UIPickerViewDelegate,UIPickerViewDataSource {

   
    /* OUTLETS */
    let pickerView = UIPickerView()

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
    var socialProvider = "1"
    var is_company = ""
    var is_verified = "0"
    var cpr = ""
    var UserName = ""
    var UserEmail = ""
    var UserImageURL = ""

    
    var imagePickerControllerObj:UIImagePickerController!
    var job_category_id = ""
    

    //MARK: - UIView Life Cycle -
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.setupView()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        pickerView.frame = CGRect(x: 0, y: 44, width: UIScreen.main.bounds.size.width, height: 253)
        pickerView.delegate = self
        pickerView.dataSource = self
    }
    
    func setupView()  {
        placesClient = GMSPlacesClient.shared()
        
        imgProfileUser.backgroundColor = UIColor.gray
        imgProfileUser.layer.cornerRadius = 45
        imgProfileUser.layer.masksToBounds = true
        
        
        let tapGesture = UITapGestureRecognizer()
        tapGesture.addTarget(self, action: #selector(self.OpenImagePicker))
        imgProfileUser.isUserInteractionEnabled = true
        imgProfileUser.addGestureRecognizer(tapGesture)
        
        
        let hideTap = UITapGestureRecognizer()
        hideTap.addTarget(self, action: #selector(self.hideKeyBoard))
        self.view.isUserInteractionEnabled = true
        self.view.addGestureRecognizer(hideTap)
        
        
        imagePickerControllerObj = UIImagePickerController()
        imagePickerControllerObj.delegate = self
        imagePickerControllerObj.sourceType = .photoLibrary
        
        if userType == .employee {
            CPRViewHeightConstraint.constant = 0
            companyViewHeightConstraints.constant = 0
            
            self.companyView.isHidden = true
            self.cprView.isHidden = true
            role_Id = "2"
            
            if let userDetail = UserDefaults.standard.object(forKey: kUserCategory) as? Data {
                userCategory = EmployeeCategory(data: userDetail)
                self.txtDriver.text = userCategory.data[0].name
                job_category_id = userCategory.data[0].id
            }else{
                self.getJobCategory()
            }
            
        }else{
            driverViewHeightConstraints.constant = 0
            self.driverView.isHidden = true
            role_Id = "3"
            is_company = "0"
        }
      
        if socialProvider == "2" {
            txtName.text = UserName
            txtEmail.text = UserEmail
            txtEmail.textColor = UIColor.gray
            txtEmail.isUserInteractionEnabled = false
            let URLImg = URL(string: UserImageURL)
            self.imgProfileUser.sd_setImage(with: URLImg)
        }
    }
    
    //MARK: - UIView Action -
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
        
        self.view.endEditing(true)

        self.txtCPR.text = ""
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
        if is_company == "1" {
             sender.inputView = nil
            
        }else{
            let datePickerView:UIDatePicker = UIDatePicker()
            datePickerView.datePickerMode = UIDatePickerMode.date
            datePickerView.maximumDate = Calendar.current.date(byAdding: .year, value: -12, to: Date())
            sender.inputView = datePickerView
            datePickerView.addTarget(self, action: #selector(EmployeeRegVC.datePickerValueChanged), for: UIControlEvents.valueChanged)
        }
    }
    
    @objc func datePickerValueChanged(sender:UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        dateFormatter.dateFormat = "yyyy-MM-dd"
        txtDate.text = dateFormatter.string(from: sender.date)
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
    
    @IBAction func btnSignupAct(_ sender: Any) {
        
        if userType == .employee {
            if validation() {
                self.registerWithParameter()
            }
        }else{
            if EmployerValidation() {
                self.registerWithParameter()
            }
        }
    }
    @IBAction func btnSigninAct(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func OpenImagePicker()
    {
        imagePickerControllerObj.allowsEditing = false
        present(imagePickerControllerObj, animated: true, completion: nil)
    }
    
    @objc func hideKeyBoard()
    {
       self.view.endEditing(true)
    }
    
    
    
    //MARK: - PickerView  Delegate
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return userCategory.data.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return userCategory.data[row].name
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.txtDriver.text = userCategory.data[row].name
        job_category_id = userCategory.data[row].id
    }
    
    //MARK: - Image PickerController Delegate -
    
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
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if textField == txtDriver{
            txtDriver.inputView = self.pickerView
        }
    }
    
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
        else if txtContact == textField {
            let maxLength = 20
            let currentString: NSString = textField.text! as NSString
            let newString: NSString =
                currentString.replacingCharacters(in: range, with: string) as NSString
            return newString.length <= maxLength
        }
        else if txtDate == textField && is_company == "1"{
            let maxLength = 2
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
        
        if txtName.text?.trim.length == 0 {
            showAlert(popUpMessage.emptyName.rawValue)
            return false
        }
       else if txtEmail.text?.trim.length == 0 {
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
        else if txtAddress.text?.trim.length == 0 {
            showAlert(popUpMessage.emptyAddress.rawValue)
            return false
        }
        else if txtDate.text?.trim.length == 0 {
            showAlert(popUpMessage.emptyBirthdate.rawValue)
            return false
        }
        else if txtContact.text?.trim.length == 0 {
            showAlert(popUpMessage.emptyContact.rawValue)
            return false
        }
        else if (txtContact.text!.length < 6 || txtContact.text!.length > 20) {
            showAlert(popUpMessage.MobileValid.rawValue)
            return false
        }
        else if txtDriver.text?.trim.length == 0 {
            showAlert(popUpMessage.emptyCategory.rawValue)
            return false
        }
        else if txtPassword.text?.trim.length == 0 {
            showAlert(popUpMessage.emptyPassword.rawValue)
            return false
        }
        else if txtConfirmPassword.text?.trim.length == 0 {
            showAlert(popUpMessage.emptyConfirmPassword.rawValue)
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
        else if txtPassword.text != txtConfirmPassword.text  {
            showAlert(popUpMessage.SamePassword.rawValue)
            return false
        }
        else if (self.imgProfileUser.image == nil){
            showAlert(popUpMessage.uploadImageError.rawValue)
            return false
        }
        else{
            return true
        }
    }
    func EmployerValidation() -> Bool
    {
        
        if txtName.text?.trim.length == 0 {
            showAlert(popUpMessage.emptyName.rawValue)
            return false
        }
        else if txtEmail.text?.trim.length == 0 {
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
        else if txtAddress.text?.trim.length == 0 {
            showAlert(popUpMessage.emptyAddress.rawValue)
            return false
        }
        else if txtCPR.text?.trim.length == 0 && is_company == "0" {
            
            showAlert(popUpMessage.emptyCPR.rawValue)
            return false
        }
        else if txtCPR.text?.trim.length == 0 && is_company == "1" {
            
            showAlert(popUpMessage.emptyCVR.rawValue)
            return false
        }
        else if txtDate.text?.trim.length == 0 && is_company == "0"{
            showAlert(popUpMessage.emptyBirthdate.rawValue)
            return false
        }
        else if txtDate.text?.trim.length == 0 && is_company == "1"{
            showAlert(popUpMessage.emptyAge.rawValue)
            return false
        }
        else if txtContact.text?.trim.length == 0 {
            showAlert(popUpMessage.emptyContact.rawValue)
            return false
        }
        else if (txtContact.text!.length < 6 || txtContact.text!.length > 20) {
            showAlert(popUpMessage.MobileValid.rawValue)
            return false
        }
        else if txtPassword.text?.trim.length == 0 {
            showAlert(popUpMessage.emptyPassword.rawValue)
            return false
        }
        else if txtConfirmPassword.text?.trim.length == 0 {
            showAlert(popUpMessage.emptyConfirmPassword.rawValue)
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
        else if txtPassword.text != txtConfirmPassword.text  {
            showAlert(popUpMessage.SamePassword.rawValue)
            return false
        }
        else if (self.imgProfileUser.image == nil){
            showAlert(popUpMessage.uploadImageError.rawValue)
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
        txtAddress.text = place.name
        user_lat = "\(place.coordinate.latitude)"
        user_lng = "\(place.coordinate.longitude)"
        dismiss(animated: true, completion: nil)
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
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
