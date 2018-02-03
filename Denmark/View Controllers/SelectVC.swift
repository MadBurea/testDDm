//
//  SelectVC.swift
//  Denmark
//
//  Created by InexTure on 16/01/18.
//  Copyright © 2018 InexTure. All rights reserved.
//

import UIKit

class SelectVC: UIViewController {

    @IBOutlet weak var lblWho: UILabel!
    
    @IBOutlet weak var lblDescription: UILabel!
    
    @IBOutlet weak var btnEmployer: UIButton!
    
    @IBOutlet weak var imgSelEmployee: UIImageView!
    @IBOutlet weak var imgSelEmployer: UIImageView!
    @IBOutlet weak var btnEmployee: UIButton!
    @IBOutlet weak var lblEmployee: UILabel!
    @IBOutlet weak var lblEmployer: UILabel!
    
    // MARK: - Life Cycle -
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.setUpScreen()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - UIView Method
    
    func setUpScreen()
    {
        lblWho.text = kWhoAre
        lblEmployee.text = kEmployee
        lblEmployer.text = kEmployer
        lblDescription.text = kSelDec
        
        // Default Employer Selected
        imgSelEmployer.isHidden = true
        imgSelEmployee.isHidden = true
    }
    func moveToLogin(isFromEmpr: Bool)
    {
        let loginVCObj = self.storyboard?.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
        loginVCObj.isFromEmployee = isFromEmpr
        self.navigationController?.pushViewController(loginVCObj, animated: true)
    }
    // MARK: - UIView Action -
    @IBAction func btnBackAct(_ sender: Any)
    {
       self.navigationController?.popViewController(animated: true)
    }
    @IBAction func btnEmployeerAct(_ sender: Any)
    {
        imgSelEmployer.isHidden = false
        imgSelEmployee.isHidden = true
        
        let when = DispatchTime.now() + 0.1 // change 2 to desired number of seconds
        DispatchQueue.main.asyncAfter(deadline: when) {
            // Your code with delay
            userType = .employer
            self.moveToLogin(isFromEmpr: true)
        }
    }

    @IBAction func btnEmployeeAct(_ sender: Any)
    {
        imgSelEmployer.isHidden = true
        imgSelEmployee.isHidden = false
        
        let when = DispatchTime.now() + 0.1
        DispatchQueue.main.asyncAfter(deadline: when) {
            userType = .employee
            self.moveToLogin(isFromEmpr: false)
        }
        
    }
    
}
