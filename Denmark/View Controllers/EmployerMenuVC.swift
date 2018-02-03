//
//  EmployerMenuVC.swift
//  Denmark
//
//  Created by Lokesh Dudhat on 1/26/18.
//  Copyright © 2018 InexTure. All rights reserved.
//

import UIKit

class EmployerMenuVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func btnCloseClick(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
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
    @IBAction func btnHomeClick(_ sender: Any) {
        if let navController = appDelegate.window?.rootViewController as? NavEmployerVC {
            self.dismiss(animated: true, completion: {
                navController.popToRootViewController(animated: true)
            })
        }
    }
    @IBAction func btnProfileClick(_ sender: Any) {
        if let navController = appDelegate.window?.rootViewController as? NavEmployerVC {
            self.dismiss(animated: true, completion: {
                if let controller = mainStory.instantiateViewController(withIdentifier: "ProfileVC") as? ProfileVC {
                    navController.pushViewController(controller, animated: true)
                }
            })
        }
    }
    @IBAction func btnNotificationClick(_ sender: Any) {
        self.dismiss(animated: true, completion: {
            
        })
    }
    @IBAction func btnAwaitedServiceClick(_ sender: Any) {
        if let navController = appDelegate.window?.rootViewController as? NavEmployerVC {
            self.dismiss(animated: true, completion: {
                if let controller = mainStory.instantiateViewController(withIdentifier: "ServicesVC") as? ServicesVC {
                    controller.isBook = false
                    navController.pushViewController(controller, animated: true)
                }
            })
        }
    }
    @IBAction func btnBookedServicesClick(_ sender: Any) {
        if let navController = appDelegate.window?.rootViewController as? NavEmployerVC {
            self.dismiss(animated: true, completion: {
                if let controller = mainStory.instantiateViewController(withIdentifier: "ServicesVC") as? ServicesVC {
                    controller.isBook = true
                    navController.pushViewController(controller, animated: true)
                }
            })
        }
    }
    @IBAction func btnCreateJobClick(_ sender: Any) {
        if let navController = appDelegate.window?.rootViewController as? NavEmployerVC {
            self.dismiss(animated: true, completion: {
                if let controller = mainStory.instantiateViewController(withIdentifier: "AddJobVC") as? AddJobVC {
                    navController.pushViewController(controller, animated: true)
                }
            })
        }
    }
    @IBAction func btnJobListClick(_ sender: Any) {
        if let navController = appDelegate.window?.rootViewController as? NavEmployerVC {
            self.dismiss(animated: true, completion: {
                if let controller = mainStory.instantiateViewController(withIdentifier: "JobListVC") as? JobListVC {
                    navController.pushViewController(controller, animated: true)
                }
            })
        }
    }
    @IBAction func btnPolicyClick(_ sender: Any) {
        self.dismiss(animated: true, completion: {
            
        })
    }
    @IBAction func btnAboutClick(_ sender: Any) {
        self.dismiss(animated: true, completion: {
            
        })
    }
    @IBAction func btnContactClick(_ sender: Any) {
        self.dismiss(animated: true, completion: {
            
        })
    }
    @IBAction func btnLogoutClick(_ sender: Any) {
        self.dismiss(animated: true, completion: {
            if let controller = mainStory.instantiateViewController(withIdentifier: "NavLoginVC") as? NavLoginVC {
                appDelegate.window?.rootViewController = controller
            }
        })
    }
}
