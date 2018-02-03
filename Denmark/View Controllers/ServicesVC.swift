//
//  ServicesVC.swift
//  Denmark
//
//  Created by Lokesh Dudhat on 1/26/18.
//  Copyright © 2018 InexTure. All rights reserved.
//

import UIKit

class ServicesVC: UIViewController {
    @IBOutlet var constraintLeading: NSLayoutConstraint!
    @IBOutlet var scrollview: UIScrollView!
    var isBook = false
    var awaitController: AwaitServicesVC?
    var bookController: BookServicesVC?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "SERVICE"
        // Do any additional setup after loading the view.
        setupBack()
        if isBook {
            self.scrollview.setContentOffset(CGPoint(x: appWidth, y: 0), animated: false)
            self.constraintLeading.constant = appWidth / 2
        }
        else {
            self.scrollview.setContentOffset(CGPoint(x: 0, y: 0), animated: false)
            self.constraintLeading.constant = 0
        }
        self.view.layoutIfNeeded()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AwaitServicesVC" {
            guard let connectContainerViewController = segue.destination as? AwaitServicesVC  else {
                return
            }
            awaitController = connectContainerViewController
        }
        else if segue.identifier == "BookServicesVC" {
            guard let connectContainerViewController = segue.destination as? BookServicesVC else {
                return
            }
            bookController = connectContainerViewController
        }
    }
    @IBAction func btnAwaitClick(_ sender: Any) {
        self.scrollview.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
    }
    @IBAction func btnBookClick(_ sender: Any) {
        self.scrollview.setContentOffset(CGPoint(x: appWidth, y: 0), animated: true)
    }
}
extension ServicesVC: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.constraintLeading.constant = scrollView.contentOffset.x / 2
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if self.scrollview.contentOffset.x == 0 {
            
        }
        else if self.scrollview.contentOffset.x == appWidth {
            
        }
    }
}
