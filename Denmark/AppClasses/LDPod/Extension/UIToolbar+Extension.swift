//
//  UIToolbar+Extension.swift
//  Pods
//
//  Created by Lokesh on 09/05/16.
//
//

import Foundation
import UIKit

// MARK: - UIToolbar Extension -
extension UIToolbar {
    
    func hideHairline() {
        let toolBarImageView = hairlineImageViewInToolbar(self)
        toolBarImageView!.isHidden = true
    }
    
    func showHairline() {
        let toolBarImageView = hairlineImageViewInToolbar(self)
        toolBarImageView!.isHidden = false
    }
    
    fileprivate func hairlineImageViewInToolbar(_ view: UIView) -> UIImageView? {
        
        if view is UIImageView && view.bounds.height <= 1.0 {
            return (view as! UIImageView)
        }
        
        let subviews = (view.subviews as [UIView])
        for subview: UIView in subviews {
            if let imageView: UIImageView = hairlineImageViewInToolbar(subview) {
                return imageView
            }
        }
        
        return nil
    }
    
}
