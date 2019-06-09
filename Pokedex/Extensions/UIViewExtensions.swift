//
//  UIViewExtensions.swift
//  Pokedex
//
//  Created by Juliano Nardon on 07/06/19.
//  Copyright © 2019 CWI Software. All rights reserved.
//
import UIKit

extension UIView {
    @IBInspectable var borderColor: UIColor? {
        get { return layer.borderColor.map(UIColor.init) }
        set { layer.borderColor = newValue?.cgColor }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        get { return layer.borderWidth }
        set { layer.borderWidth = newValue }
    }
    
    @IBInspectable var cornerRadius: CGFloat {
        get { return layer.cornerRadius }
        set {
            layer.cornerRadius = newValue
            clipsToBounds = newValue > 0
        }
    }
}

extension UISearchController {
    
    func setLayoutSearchController(tintColor: UIColor, barTintColor: UIColor,
                                   backgroundColor: UIColor, cornerRadius: CGFloat) {
        let scb = self.searchBar
        scb.tintColor = tintColor
        scb.barTintColor = barTintColor
        
        if let textfield = scb.value(forKey: "searchField") as? UITextField {
            if let backgroundview = textfield.subviews.first {
                
                // Background color
                backgroundview.backgroundColor = backgroundColor
                
                // Rounded corner
                backgroundview.layer.cornerRadius = cornerRadius
                backgroundview.clipsToBounds = true
            }
        }
    }
    
}