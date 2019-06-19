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
    
    private let presenter = PokemonListPresenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configTable()
        self.presenter.view = self
        self.presenter.fetchData()
        self.createSearchBar()
    }
    
    private func configTable() {
        self.tableView.delegate = self
        self.tableView.dataSource = presenter
    }
    
    func createSearchBar() {
        let searchBar = UISearchController(searchResultsController: nil)
        
        searchBar.delegate = self
        searchBar.setLayoutSearchController(tintColor: #colorLiteral(red: 0.370555222, green: 0.3705646992, blue: 0.3705595732, alpha: 1), barTintColor: #colorLiteral(red: 0.370555222, green: 0.3705646992, blue: 0.3705595732, alpha: 1), backgroundColor: #colorLiteral(red: 0.9215686275, green: 0.9215686275, blue: 0.9215686275, alpha: 0.6), cornerRadius: 18)
    
        navigationItem.searchController = searchBar
    }

}



extension PokemonListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = self.storyboard
        if let detailViewController = storyboard?.instantiateViewController(withIdentifier: "PokemonDetailViewController") as? PokemonDetailViewController {
            detailViewController.pokemon = self.presenter.pokemon(at: indexPath.row)
            self.navigationController?.present(detailViewController, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let actionType = self.presenter.swipeAction(for: indexPath.row)
        
        let contextualAction = UIContextualAction(style: .normal, title: actionType.text) {
            (action, view, handler) in
            
            self.presenter.swipe(at: indexPath.row)
            
            handler(true)
        }
        
        contextualAction.backgroundColor = actionType.color
        
        let configuration = UISwipeActionsConfiguration(actions: [contextualAction])
        return configuration
    }
    
}

enum PokemonSwipeAction {
    case addFavorite, removeFavorite
    
    var text: String {
        switch self {
        case .addFavorite:
            return "Adicionar"
        case .removeFavorite:
            return "Remover"
        }
    }
    
    var color: UIColor {
        switch self {
        case .addFavorite:
            return #colorLiteral(red: 0.851000011, green: 0.2590000033, blue: 0.3370000124, alpha: 1)
        case .removeFavorite:
            return #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        }
    }
}

extension PokemonListViewController: PokemonListViewType {
    func reloadData() {
        self.activityIndicatorView.isHidden = true
        self.tableView.reloadData()
    }
}




