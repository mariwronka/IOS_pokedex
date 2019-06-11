//
//  Move.swift
//  Pokedex
//
//  Created by Marielle Wronka on 10/06/2019.
//  Copyright © 2019 CWI Software. All rights reserved.
//

import Foundation

struct Move: Codable {
    let name: String
    let learnLevel: Int
    let type: PokemonType
}
