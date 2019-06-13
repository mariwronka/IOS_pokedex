//
//  ViewController.swift
//  Pokedex
//
//  Created by Juliano Nardon on 07/06/19.
//  Copyright © 2019 CWI Software. All rights reserved.
//

import UIKit

class PokemonListViewController: UIViewController, UISearchControllerDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var activityIndicatorView: UIView!
    
    var pokemonList = [Pokemon]()
    
    let requestMaker = RequestMaker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configTable()
        self.fetchData()
        self.createSearchBar()
    }
    
    private func configTable() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    func createSearchBar() {
        let searchBar = UISearchController(searchResultsController: nil)
        
        searchBar.delegate = self
        searchBar.setLayoutSearchController(tintColor: #colorLiteral(red: 0.370555222, green: 0.3705646992, blue: 0.3705595732, alpha: 1), barTintColor: #colorLiteral(red: 0.370555222, green: 0.3705646992, blue: 0.3705595732, alpha: 1), backgroundColor: #colorLiteral(red: 0.9215686275, green: 0.9215686275, blue: 0.9215686275, alpha: 0.6), cornerRadius: 18)
    
        navigationItem.searchController = searchBar
    }

}

extension PokemonListViewController: UITableViewDataSource {
    
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

extension PokemonListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = self.storyboard
        if let detailViewController = storyboard?.instantiateViewController(withIdentifier: "PokemonDetailViewController") as? PokemonDetailViewController {
            detailViewController.pokemon = self.pokemonList[indexPath.row]
            self.navigationController?.present(detailViewController, animated: true)
        }
    }
    
}

extension PokemonListViewController {
    
    func fetchData() {
        requestMaker.make(withEndpoint: .list) {
            (pokemonList: PokemonList) in
            self.pokemonList = pokemonList.pokemons
            DispatchQueue.main.async {
                self.activityIndicatorView.isHidden = true
                self.tableView.reloadData()
            }
        }
    }
    
}

