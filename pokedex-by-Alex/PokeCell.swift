//
//  PokeCell.swift
//  pokedex-by-Alex
//
//  Created by Alex Nguyen on 2016-01-21.
//  Copyright © 2016 Alex Nguyen. All rights reserved.
//

import UIKit

class PokeCell: UICollectionViewCell {
    @IBOutlet weak var thumbImg: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    
    var pokemon: Pokemon!
    
    func configureCell(pokemon: Pokemon){
        self.pokemon = pokemon
        
        nameLbl.text = self.pokemon.name.capitalizedString //Capitalized string = caps first letter
        thumbImg.image = UIImage(named: "\(self.pokemon.pokedexId)")
    }

}
