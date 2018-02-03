//
//  ProfileVC.swift
//  Denmark
//
//  Created by Lokesh Dudhat on 1/26/18.
//  Copyright © 2018 InexTure. All rights reserved.
//

import UIKit

class ProfileVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupBack()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    @IBAction func btnBackAct(_ sender: Any)
    {
        self.navigationController?.popViewController(animated: true)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func btnProfileClick(_ sender: Any) {
    }
    @IBAction func btnExperienceClick(_ sender: Any) {
    }
    @IBAction func btnPaymentClick(_ sender: Any) {
    }
    @IBAction func btnNotificationClick(_ sender: Any) {
    }
    @IBAction func btnSettingClick(_ sender: Any) {
    }
    @IBAction func btnLogoutClick(_ sender: Any) {
        if let controller = mainStory.instantiateViewController(withIdentifier: "NavLoginVC") as? NavLoginVC {
            appDelegate.window?.rootViewController = controller
        }
    }
}
