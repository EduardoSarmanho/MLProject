//
//  PokemonDetailViewController.swift
//  MLProject
//
//  Created by Gustavo Travassos on 30/04/20.
//  Copyright © 2020 Eduardo Sarmanho. All rights reserved.
//

import UIKit

class PokemonDetailViewController: UIViewController {

    var text: String?
    
    @IBOutlet weak var randomLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        randomLabel.text = text
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
