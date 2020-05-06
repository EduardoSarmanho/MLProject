//
//  PokemonDetailViewController.swift
//  MLProject
//
//  Created by Gustavo Travassos on 30/04/20.
//  Copyright © 2020 Eduardo Sarmanho. All rights reserved.
//

import UIKit

class PokemonDetailViewController: UIViewController {

    var pokemon: Pokemon?
    
    @IBOutlet weak var image: UIImageView!
    var text: String?
    
    @IBOutlet weak var name: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        name.text = pokemon?.name?.capitalized
        image.image = pokemon?.image
        
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
