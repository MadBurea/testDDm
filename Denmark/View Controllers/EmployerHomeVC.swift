//
//  EmployerHomeVC.swift
//  Denmark
//
//  Created by Lokesh Dudhat on 1/26/18.
//  Copyright © 2018 InexTure. All rights reserved.
//

import UIKit

class EmployerHomeVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "SEARCH"
        // Do any additional setup after loading the view.
        let barButton = UIBarButtonItem(image: #imageLiteral(resourceName: "ic_menu").withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(EmployerHomeVC.btnMenuClick))
        self.navigationItem.leftBarButtonItem = barButton
        setupBack()
    }
    @objc func btnMenuClick() {
        if let controller = mainStory.instantiateViewController(withIdentifier: "EmployerMenuVC") as? EmployerMenuVC {
            self.present(controller, animated: true, completion: nil)
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func btnSearchClick(_ sender: Any) {
        if let controller = mainStory.instantiateViewController(withIdentifier: "MatchListVC") as? MatchListVC {
            self.navigationController?.pushViewController(controller, animated: true)
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
