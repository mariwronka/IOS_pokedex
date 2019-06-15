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
        self.transform = self.transform.scaledBy(x: 1, y: 5)
        self.layer.cornerRadius = 10
        self.progressTintColor = color
        self.clipsToBounds = true
        self.layer.sublayers![1].cornerRadius = 10
        self.layer.cornerRadius = 10
        self.subviews[1].clipsToBounds = true
    }

}
