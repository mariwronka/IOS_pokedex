//
//  MovesTableViewCell.swift
//  Pokedex
//
//  Created by Marielle Wronka on 10/06/2019.
//  Copyright © 2019 CWI Software. All rights reserved.
//

import UIKit

class MovesTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var typeImageView: UIImageView!
    @IBOutlet weak var backgroudType: UIView!
    
    func config(with model: Move) {
        typeImageView.image = model.type.icon
        backgroudType.backgroundColor = model.type.color
        nameLabel.text = model.name.capitalized
    }
    
}
