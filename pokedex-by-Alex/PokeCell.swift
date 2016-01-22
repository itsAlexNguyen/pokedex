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

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        //Always set corner raduis for aesthetics
        self.layer.cornerRadius = 5.0
    }
    
    func configureCell(pokemon: Pokemon){
        self.pokemon = pokemon
        
        nameLbl.text = self.pokemon.name.capitalizedString //Capitalized string = caps first letter
        thumbImg.image = UIImage(named: "\(self.pokemon.pokedexId)")
    }

}
