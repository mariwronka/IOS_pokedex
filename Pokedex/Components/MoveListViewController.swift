//
//  MovesViewController.swift
//  Pokedex
//
//  Created by Marielle Wronka on 10/06/2019.
//  Copyright © 2019 CWI Software. All rights reserved.
//

import UIKit

class MoveListViewController: UIViewController, UISearchControllerDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var moveList = [Move]()
    
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
        searchBar.setLayoutSearchController(tintColor: #colorLiteral(red: 0.370555222, green: 0.3705646992, blue: 0.3705595732, alpha: 1),
                                            barTintColor: #colorLiteral(red: 0.370555222, green: 0.3705646992, blue: 0.3705595732, alpha: 1),
                                            backgroundColor: #colorLiteral(red: 0.9215686275, green: 0.9215686275, blue: 0.9215686275, alpha: 0.6),
                                            cornerRadius: 18)
        
        navigationItem.searchController = searchBar
    }

}

extension MoveListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.moveList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "move", for: indexPath)
        
        if let moveCell = cell as? MovesTableViewCell {
            moveCell.config(with: self.moveList[indexPath.row])
        }
        return cell
    }
    
}

extension MoveListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = self.storyboard
        if let detailViewController = storyboard?.instantiateViewController(withIdentifier: "MoveDetailViewController") {
            self.navigationController?.present(detailViewController, animated: true)
        }
    }
}

extension MoveListViewController {
    
    func fetchData() {
        requestMaker.make(withEndpoint: .move) { 
            (moves: [Move]) in
            self.moveList = moves
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
}
