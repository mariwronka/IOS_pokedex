//
//  PokemonTableViewCell.swift
//  Pokedex
//
//  Created by Marielle Wronka on 08/06/2019.
//  Copyright © 2019 CWI Software. All rights reserved.
//

import UIKit

class PokemonTableViewCell: UITableViewCell {
    
    @IBOutlet weak var pictureImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var primaryTypeImageView: UIImageView!
    @IBOutlet weak var secondaryTypeImageView: UIImageView!
    @IBOutlet weak var primaryBackgroudType: UIView!
    @IBOutlet weak var secondaryBackgroudType: UIView!

    func config(with model: Pokemon) {
        pictureImageView.loadImage(from: model.image)
        nameLabel.text = model.name.capitalized
        if let id = Int(model.id) { idLabel.text = String(format: "#%03d", id) }
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
