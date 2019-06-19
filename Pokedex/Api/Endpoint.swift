//
//  Endpoint.swift
//  Pokedex
//
//  Created by Marielle Wronka on 19/06/2019.
//  Copyright © 2019 CWI Software. All rights reserved.
//

import Foundation

extension RequestMaker {
    
    enum Endpoint {
        case list
        case details(query: Int)
        case move
        case favorite (ids: Set<Int>)
        
        var url: String {
            switch self {
            case .list:
                return "list"
            case let .details(query):
                return "details/\(query)"
            case .move:
                return "moves"
            case let .favorite(ids):
                return "details\(destrinchIdsAsParams(ids))"
            }
        }
    }
    
}

private func destrinchIdsAsParams(_ ids: Set<Int>) -> String {
    var localCopiedIds = ids
    var result = "?id=\(localCopiedIds.removeFirst())"
    
    for id in localCopiedIds {
        result += "&id=\(id)"
    }
    
    return result
}
