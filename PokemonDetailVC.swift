//
//  PokemonDetailVC.swift
//  pokedex-by-Alex
//
//  Created by Alex Nguyen on 2016-01-22.
//  Copyright © 2016 Alex Nguyen. All rights reserved.
//

import UIKit

class PokemonDetailVC: UIViewController {
    var pokemon: Pokemon!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var mainImg: UIImageView!
    @IBOutlet weak var typeLbl: UILabel!
    @IBOutlet weak var defenseLbl: UILabel!
    @IBOutlet weak var heightLbl: UILabel!
    @IBOutlet weak var pokedexLbl: UILabel!
    @IBOutlet weak var weightLbl: UILabel!
    @IBOutlet weak var baseAtkLbl: UILabel!
    @IBOutlet weak var currentEvoImg: UIImageView!
    @IBOutlet weak var nextEvoImg: UIImageView!
    @IBOutlet weak var evoLbl: UILabel!
    @IBOutlet weak var descLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.text = pokemon.name.capitalizedString;
        mainImg.image = UIImage(named: "\(pokemon.pokedexId)")
        currentEvoImg.image = UIImage(named: "\(pokemon.pokedexId)")
        pokemon.downloadPokemonDetails { () -> () in
            self.updateUI()
        }
    }
    func updateUI(){
        self.typeLbl.text = self.pokemon.type
        self.defenseLbl.text = self.pokemon.defense
        self.heightLbl.text = self.pokemon.height
        self.pokedexLbl.text = "\(self.pokemon.pokedexId)"
        self.weightLbl.text = self.pokemon.weight
        self.baseAtkLbl.text = self.pokemon.attack
        self.descLbl.text = self.pokemon.description
        if pokemon.nextEvolutionId == "" {
            evoLbl.text == "No Evolutions"
            nextEvoImg.hidden = true
        } else {
            nextEvoImg.hidden = false
            nextEvoImg.image = UIImage(named: pokemon.nextEvolutionId)
            var str = "Next Evolution: \(pokemon.nextEvolutionText)"
            
            if pokemon.nextEvolutionLvl != "" {
                str += " - LVL \(pokemon.nextEvolutionLvl)"
            }
            evoLbl.text = str
        }
    }
    @IBAction func backBtnPressed(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
}
