//
//  Pokemon.swift
//  Pokedex
//
//  Created by Marielle Wronka on 08/06/2019.
//  Copyright © 2019 CWI Software. All rights reserved.
//

import Foundation

struct PokemonResponse: Codable {
    let list: PokemonList
}

struct PokemonList: Codable { let pokemons: [Pokemon] }

struct Pokemon : Codable {
    
    let id: Int
    let name: String
    let image: String
    let types: [PokemonType]
    let description: String?
    let stats: [Stats]?
    
    var mainType: PokemonType? {
        return self.types.first
    }
    
    var strongerStart: Stats? {
        return self.stats?.first
    }
    
}

struct Stats: Codable {
    let value: Int
    let name: String
}
