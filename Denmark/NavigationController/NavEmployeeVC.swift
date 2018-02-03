//
//  NavEmployeeVC.swift
//  Denmark
//
//  Created by Lokesh Dudhat on 1/30/18.
//  Copyright © 2018 InexTure. All rights reserved.
//

import UIKit

class NavEmployeeVC: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationBar.setBackgroundImage(#imageLiteral(resourceName: "bg_nav_header"), for: .default)
        let attrs = [
            NSAttributedStringKey.foregroundColor: UIColor.white
        ]
        self.navigationBar.titleTextAttributes = attrs
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
