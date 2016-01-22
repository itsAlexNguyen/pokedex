//
//  Pokemon.swift
//  pokedex-by-Alex
//
//  Created by Alex Nguyen on 2016-01-21.
//  Copyright © 2016 Alex Nguyen. All rights reserved.
//

import Foundation

class Pokemon {
    //Pokemon Object Properties
    private var _name: String!
    private var _pokedexId: Int!
    
    var name: String {
        return _name
    }
    var pokedexId: Int {
        return _pokedexId
    }
    
    init(name: String, pokedexId: Int){
        self._name = name
        self._pokedexId = pokedexId
    }
}