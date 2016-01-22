//
//  Pokemon.swift
//  pokedex-by-Alex
//
//  Created by Alex Nguyen on 2016-01-21.
//  Copyright © 2016 Alex Nguyen. All rights reserved.
//

import Foundation
import Alamofire

class Pokemon {
    //Pokemon Object Properties
    private var _name: String!
    private var _pokedexId: Int!
    private var _description: String!
    private var _type: String!
    private var _defense: String!
    private var _height: String!
    private var _weight: String!
    private var _attack: String!
    private var _nextEvolutionText: String!
    private var _nextEvolitionId: String!
    private var _nextEvolutionLvl: String!
    private var _pokemonURL: String!
    
    var nextEvolutionId: String {
        if _nextEvolitionId == nil {
            _nextEvolitionId = ""
            return _nextEvolitionId
        }
        return _nextEvolitionId
    }
    var nextEvolutionLvl: String {
        return _nextEvolutionLvl
    }
    var name: String {
        return _name
    }
    var pokedexId: Int {
        return _pokedexId
    }
    var description: String {
        return _description
    }
    var type: String {
        return _type
    }
    var defense: String {
        return _defense
    }
    var height: String {
        return _height
    }
    var weight: String {
        return _weight
    }
    var attack: String {
        return _attack
    }
    var nextEvolutionText: String {
        return _nextEvolutionText
    }
    
    init(name: String, pokedexId: Int){
        self._name = name
        self._pokedexId = pokedexId
        
        _pokemonURL = "\(URL_BASE)\(URL_POKEMON)\(self.pokedexId)/"
    }
    
    func downloadPokemonDetails(var completed: DownloadComplete){
        let url = NSURL(string: _pokemonURL)
        
        Alamofire.request(.GET, url!).responseJSON { response in
            let result = response.result
            if let dict = result.value as? Dictionary<String, AnyObject> {
                if let weight = dict["weight"] as? String {
                    self._weight = weight
                }
                if let height = dict["height"] as? String {
                    self._height = height
                }
                if let attack = dict["attack"] as? Int {
                    self._attack = "\(attack)"
                }
                if let defense = dict["defense"] as? Int {
                    self._defense = "\(defense)"
                }

                if let types = dict["types"] as? [Dictionary<String, String>] where types.count > 0{
                    if let name = types[0]["name"] {
                        self._type = name.capitalizedString
                    }
                    if types.count > 1 {
                        for var x = 1; x < types.count; x++ {
                            if let name = types[x]["name"] {
                                self._type! += "/\(name.capitalizedString)"
                            }
                        }
                    }
                } else {
                    self._type = "No Type"
                }
                
                print(self._type)
                
                //Description
                if let descArr = dict["descriptions"] as? [Dictionary<String, String>] where descArr.count > 0 {
                    if let url = descArr[0]["resource_uri"]{
                        print (url)
                        Alamofire.request(.GET, NSURL(string: "\(URL_BASE)\(url)")!).responseJSON { response in
                            let result = response.result
                            
                            if let descDict = result.value as? Dictionary<String, AnyObject> {
                                if let description = descDict["description"] as? String {
                                    self._description = description
                                    print(self.description)
                                }
                            }
                            completed()
                        }
                    }
                } else {
                    self._description = "No description availiable"
                }
                
                if let evolutions = dict["evolutions"] as? [Dictionary<String, AnyObject>] where evolutions.count > 0{
                    if let to = evolutions[0]["to"] as? String {
                        //We are unable to suport mega pokemon right now
                        if to.rangeOfString("mega") == nil {
                            if let uri = evolutions[0]["resource_uri"] as? String {
                                let newString = uri.stringByReplacingOccurrencesOfString("/api/v1/pokemon/", withString: "")
                                let num = newString.stringByReplacingOccurrencesOfString("/", withString: "")
                                self._nextEvolitionId = num
                                self._nextEvolutionText = to
                                
                                if let lvl = evolutions[0]["level"] as? Int {
                                    self._nextEvolutionLvl = "\(lvl)"
                                }
                                print(self._nextEvolutionLvl)
                                print(self._nextEvolitionId)
                                print(self._nextEvolutionText)
                            }
                        }
                    }
                }
            }
        }
    }
}