//
//  ViewController.swift
//  Denmark
//
//  Created by InexTure on 12/01/18.
//  Copyright © 2018 InexTure. All rights reserved.
//

import UIKit

class ViewController: UIViewController , UIScrollViewDelegate{

    @IBOutlet weak var lblAppName: UILabel!
    @IBOutlet weak var lblWelcome: UILabel!
    @IBOutlet weak var ObjScrollView: UIScrollView!
    @IBOutlet weak var btnStart: UIButton!
    @IBOutlet weak var objPageControl: UIPageControl!
    
    var colors = [UIColor.red, UIColor.blue, UIColor.green, UIColor.yellow]
    var frame: CGRect = CGRect(x:0, y:0, width:0, height:0)
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.setUpScreen()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.setUpScrollView()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    // MARK: UIView Method
    func setUpScreen()
    {
        lblAppName.text = kAppName
        lblWelcome.text = kWelComeMsg
        btnStart.setTitle(kBtnStartText, for: .normal)
        
        self.configurePageControl()
    }
    func setUpScrollView() {
        ObjScrollView.delegate = self
        ObjScrollView.isPagingEnabled = true
        
        for index in 0..<4 {
            
            frame.origin.x = UIScreen.main.bounds.size.width * CGFloat(index)
            frame.size.width = UIScreen.main.bounds.size.width
            frame.size.height = self.ObjScrollView.bounds.size.height
            
            let subView = UIView(frame: frame)
            //            subView.backgroundColor = colors[index]
            subView.backgroundColor = UIColor.clear
            
            let lbl = UILabel(frame: CGRect(x: 40, y: 0, width: frame.size.width - 80, height: frame.size.height - objPageControl.frame.size.height))
            lbl.numberOfLines = 0
   
            lbl.textAlignment = .center
            lbl.text = "The easiest way to find your job. Explore. The easiest way to find your job. Explore. \(index)"
            lbl.backgroundColor = UIColor.clear
            subView.addSubview(lbl)
            self.ObjScrollView.addSubview(subView)
        }
        
        self.ObjScrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width * 4,height: self.ObjScrollView.frame.size.height)
        self.ObjScrollView.showsHorizontalScrollIndicator = false
        
        objPageControl.addTarget(self, action: #selector(self.changePage(sender:)), for: UIControlEvents.valueChanged)
    }
    
    // configurePageControl
    func configurePageControl() {
        // The total number of pages that are available is based on how many available colors we have.
        self.objPageControl.numberOfPages = colors.count
        self.objPageControl.currentPage = 0
    }
    
    // MARK: TO CHANGE WHILE CLICKING ON PAGE CONTROL
    @objc func changePage(sender: AnyObject) -> () {
        let x = CGFloat(objPageControl.currentPage) * ObjScrollView.frame.size.width
        ObjScrollView.setContentOffset(CGPoint(x:x, y:0), animated: true)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageNumber = round(scrollView.contentOffset.x / scrollView.frame.size.width)
        objPageControl.currentPage = Int(pageNumber)
    }
    
    // MARK: UIView Action Method
    @IBAction func btnStartSel(_ sender: Any)
    {
        let selectVCObj = self.storyboard?.instantiateViewController(withIdentifier: "SelectVC") as! SelectVC
        self.navigationController?.pushViewController(selectVCObj, animated: true)
    }
}

