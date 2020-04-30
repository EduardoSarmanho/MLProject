//
//  ViewController.swift
//  MLProject
//
//  Created by Eduardo Sarmanho on 28/04/20.
//  Copyright © 2020 Eduardo Sarmanho. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var pokemon = [Pokemon]()
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchPokemon()
    }

    func fetchPokemon() {
           Service.shared.fetchPokemon { (pokemon) in
               DispatchQueue.main.async {
                   self.pokemon = pokemon
               }
           }
       }
}

