//
//  CircleView.swift
//  Pokedex
//
//  Created by Marielle Wronka on 11/06/2019.
//  Copyright © 2019 CWI Software. All rights reserved.
//

import UIKit

@IBDesignable
class CircleView: UIView {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.asCircle()
        self.addShadow()

    }
    
}
