//
//  FavoriteTableViewCell.swift
//  Pokedex
//
//  Created by Marielle Wronka on 19/06/2019.
//  Copyright © 2019 CWI Software. All rights reserved.
//

import UIKit

class FavoriteCollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var pictureImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var satkLabel: UILabel!
    @IBOutlet weak var primaryTypeImageView: UIImageView!
    @IBOutlet weak var secondaryTypeImageView: UIImageView!
    @IBOutlet weak var primaryBackgroudType: UIView!
    @IBOutlet weak var secondaryBackgroudType: UIView!
    
    func config(with model: Pokemon) {
        pictureImageView.loadImage(from: model.image)
        nameLabel.text = model.name.capitalized
        satkLabel.text = model.strongerStart?.name
        primaryTypeImageView.image = model.types.first?.icon
        primaryBackgroudType.backgroundColor = model.types.first?.color
        
        if model.types.count > 1 {
            secondaryTypeImageView.image = model.types[1].icon
            secondaryBackgroudType.backgroundColor = model.types[1].color
            secondaryBackgroudType.isHidden = false
        } else {
            secondaryBackgroudType.isHidden = true
        }
    }

}
