//
//  UIProgressViewExtension.swift
//  Pokedex
//
//  Created by Marielle Wronka on 12/06/2019.
//  Copyright © 2019 CWI Software. All rights reserved.
//

import UIKit

extension UIProgressView {
    
    func configProgress(color: UIColor) {
        
        self.clipsToBounds = true
        self.subviews[1].clipsToBounds = true
        
        self.layer.cornerRadius = 8
        self.layer.sublayers![1].cornerRadius = 8
        
        self.transform = self.transform.scaledBy(x: 1, y: 5)
        self.progressTintColor = color
    }

}
