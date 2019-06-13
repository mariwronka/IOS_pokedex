//
//  CustomProgressView.swift
//  Pokedex
//
//  Created by Marielle Wronka on 12/06/2019.
//  Copyright © 2019 CWI Software. All rights reserved.
//

import UIKit

@IBDesignable
class CustomProgressView: UIProgressView {

    override func layoutSubviews() {
        super.layoutSubviews()
        
        let maskLayerPath = UIBezierPath(roundedRect: bounds, cornerRadius: 4.0)
        let maskLayer = CAShapeLayer()
        maskLayer.frame = self.bounds
        maskLayer.path = maskLayerPath.cgPath
        layer.mask = maskLayer
    }

}
