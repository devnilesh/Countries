//
//  Extensions.swift
//  Countries
//
//  Created by Nilesh Mahajan on 18/01/20.
//  Copyright © 2020 Nilesh Mahajan. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    @IBInspectable var borderColor: UIColor {
        get{
            return UIColor(cgColor: self.borderColor as! CGColor)
        }
        set{
            self.layer.borderColor = newValue.cgColor
        }
    }
    
    @IBInspectable var borderRadius: CGFloat {
        get{
            return self.borderRadius
        }
        set{
            self.layer.cornerRadius = newValue
        }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        get{
            return self.borderWidth
        }
        set{
            self.layer.borderWidth = newValue
        }
    }
    
    
    @IBInspectable var shadowColor: UIColor {
        get {
            return UIColor(cgColor: self.shadowColor as! CGColor)
        }
        set {
            self.layer.shadowColor = newValue.cgColor
        }
    }
    
    @IBInspectable var shadowOffset: CGSize {
        get {
            return self.shadowOffset
        }
        set {
            self.layer.shadowOffset = newValue
        }
    }
    
    @IBInspectable var shadowRadius: CGFloat {
        get {
            return self.shadowRadius
        }
        set {
            self.layer.shadowRadius = newValue
        }
    }
    
    @IBInspectable var shadowOpacity: Float {
        get {
            return self.shadowOpacity
        }
        set {
            self.layer.shadowOpacity = newValue
        }
    }
}
