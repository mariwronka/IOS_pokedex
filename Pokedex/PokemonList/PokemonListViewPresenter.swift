//
//  PokemonListViewPresenter.swift
//  Pokedex
//
//  Created by Marielle Wronka on 15/06/2019.
//  Copyright © 2019 CWI Software. All rights reserved.
//

import UIKit

class PokemonListPresenter: NSObject {
    
    weak var view: PokemonListViewType?
    
    private var pokemonList = [Pokemon]()
    
    private let requestMaker = RequestMaker()
    
    func pokemon(at index: Int) -> Pokemon {
        return pokemonList[index]
    }
    
}

extension PokemonListPresenter: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemonList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "pokemon", for: indexPath)
        if let pokemonCell = cell as? PokemonTableViewCell {
            pokemonCell.config(with: self.pokemonList[indexPath.row])
        }
        return cell
    }
    
}

extension PokemonListPresenter {
    
    func fetchData() {
        requestMaker.make(withEndpoint: .list) {
            (pokemonList: PokemonList) in
            self.pokemonList = pokemonList.pokemons
            DispatchQueue.main.async {
                self.view?.reloadData()
            }
        }
    }
    
}
