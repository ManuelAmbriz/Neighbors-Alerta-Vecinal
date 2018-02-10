//
//  RoundTextField.swift
//  Neighbors Alerta Vecinal Neighbors Alerta Vecinal Neighbors
//
//  Created by Manuel Ambriz on 05/10/17.
//  Copyright © 2017 Manuel Ambriz. All rights reserved.
//

import UIKit

@IBDesignable
class RoundTextField: UITextField {
    
    @IBInspectable var cornerRadius : CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = (cornerRadius > 0)
        }
    }
    
    @IBInspectable var borderWidth : CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        didSet {
            layer.borderColor = borderColor?.cgColor
        }
    }
    
    @IBInspectable var bgColor: UIColor? {
        didSet {
            backgroundColor = bgColor
        }
    }
    
    
    @IBInspectable var placeHolderColor: UIColor? {
        didSet {
            let rawString = attributedPlaceholder?.string != nil ? attributedPlaceholder!.string : ""
            let att = NSAttributedString(string:rawString, attributes: [.foregroundColor: placeHolderColor as Any])
            attributedPlaceholder = att
            
        }
    }
    func underlined(){
        let border = CALayer()
        let width = CGFloat(1.0)
        border.borderColor = UIColor.lightGray.cgColor
        border.frame = CGRect(x: 0, y: self.frame.size.height - width, width:  self.frame.size.width, height: self.frame.size.height)
        border.borderWidth = width
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
    }
}

