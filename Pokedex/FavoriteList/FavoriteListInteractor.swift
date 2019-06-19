//
//  FavoriteListInteractor.swift
//  Pokedex
//
//  Created by Marielle Wronka on 19/06/2019.
//  Copyright © 2019 CWI Software. All rights reserved.
//

import Foundation

class FavoriteListInteractor {
    
    private let requestMaker = RequestMaker()
    
    private weak var output: FavoriteListInteractorOutput?
    
    init(output: FavoriteListInteractorOutput) {
        self.output = output
    }
    
}

extension FavoriteListInteractor: FavoriteListInteractorInput {
    
    func fetchData() {
        self.requestMaker.make(withEndpoint: .favorite(ids: [1, 10])) {
            (data: [Pokemon]) in
            self.output?.dataFetched(data)
        }
    }
    
}
