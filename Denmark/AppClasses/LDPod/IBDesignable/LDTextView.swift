//
//  LDTextView.swift
//
//
//  Created by Lokesh Dudhat on 25/12/15.
//  Copyright © 2015 Lokesh Dudhat. All rights reserved.
//
import UIKit
@IBDesignable
class LDTextView : UITextView {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        NotificationCenter.default.addObserver(self, selector: #selector(LDTextView.refreshPlaceholder), name: NSNotification.Name.UITextViewTextDidChange, object: self)
    }
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        NotificationCenter.default.addObserver(self, selector: #selector(LDTextView.refreshPlaceholder), name: NSNotification.Name.UITextViewTextDidChange, object: self)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        NotificationCenter.default.addObserver(self, selector: #selector(LDTextView.refreshPlaceholder), name: NSNotification.Name.UITextViewTextDidChange, object: self)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    @IBInspectable var borderColor: UIColor = UIColor.clear {
        didSet {
            layer.borderColor = borderColor.cgColor
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }
    fileprivate var placeholderLabel: UILabel?
    fileprivate var _placeholderColor: UIColor?
    @IBInspectable  var placeholderColor : UIColor? {
        get {
            if _placeholderColor != nil {
                return _placeholderColor
            }
            return self.textColor
        }
        set {
            _placeholderColor = placeholderColor
            if placeholderLabel != nil {
                placeholderLabel!.textColor = placeholderColor
                refreshPlaceholder()
            }
        }
    }
    @IBInspectable  var placeholder : String? {
        
        get {
            return placeholderLabel?.text
        }
        
        set {
            
            if placeholderLabel == nil {
                var frm = self.bounds.insetBy(dx: 5, dy: 6)
                frm.size.height = 20
                placeholderLabel = UILabel(frame:frm)
                
                if let unwrappedPlaceholderLabel = placeholderLabel {
                    
                    unwrappedPlaceholderLabel.autoresizingMask = [.flexibleWidth, .flexibleHeight]
                    unwrappedPlaceholderLabel.lineBreakMode = .byWordWrapping
                    unwrappedPlaceholderLabel.numberOfLines = 0
                    unwrappedPlaceholderLabel.font = self.font
                    unwrappedPlaceholderLabel.backgroundColor = UIColor.clear
                    unwrappedPlaceholderLabel.textColor = placeholderColor ?? UIColor(white: 0.7, alpha: 1.0)
                    unwrappedPlaceholderLabel.alpha = 0
                    addSubview(unwrappedPlaceholderLabel)
                }
            }
            
            placeholderLabel?.text = newValue
            refreshPlaceholder()
        }
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if let unwrappedPlaceholderLabel = placeholderLabel {
            unwrappedPlaceholderLabel.sizeToFit()
            unwrappedPlaceholderLabel.frame = CGRect(x: 8, y: 8, width: self.frame.width-16, height: 20)
        }
    }
    @objc func refreshPlaceholder() {
        
        if text.characters.count != 0 {
            placeholderLabel?.alpha = 0
        } else {
            placeholderLabel?.alpha = 1
        }
    }
    
    override var text: String! {
        
        didSet {
            
            refreshPlaceholder()
            
        }
    }
    
    override var font : UIFont? {
        
        didSet {
            
            if let unwrappedFont = font {
                placeholderLabel?.font = unwrappedFont
            } else {
                placeholderLabel?.font = UIFont.systemFont(ofSize: 12)
            }
        }
    }
    
    override var delegate : UITextViewDelegate? {
        
        get {
            refreshPlaceholder()
            return super.delegate
        }
        
        set {
            super.delegate = newValue
        }
    }
}
