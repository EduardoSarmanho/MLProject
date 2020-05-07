//
//  PokedexViewController.swift
//  MLProject
//
//  Created by Gustavo Travassos on 30/04/20.
//  Copyright © 2020 Eduardo Sarmanho. All rights reserved.
//

import UIKit

class PokedexViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    static var pokemon = [Pokemon]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        fetchPokemon()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.reloadData()
        navigationController?.navigationBar.barTintColor = UIColor(named: "Vermelho Pokedex")
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]

//            UIColor(red: 255, green: 69, blue: 58, alpha: 1)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        collectionView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if segue.identifier == "goToDetail" {
            guard let destination = segue.destination as? PokemonDetailViewController else { return }
            guard let pokemonToSend = sender as? Pokemon else { return }
            destination.pokemon = pokemonToSend
        }
    }
}

extension PokedexViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return PokedexViewController.pokemon.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "pokemonCell", for: indexPath) as! PokedexCollectionViewCell
        
        if PokedexViewController.pokemon[indexPath.row].isRegistred {
            cell.imageView.image = PokedexViewController.pokemon[indexPath.row].image
            cell.nameLabel.text = PokedexViewController.pokemon[indexPath.row].name?.capitalized
        } else {
            cell.imageView.image = PokedexViewController.pokemon[indexPath.row].image?.withTintColor(.darkGray)
            cell.nameLabel.text = "?????"
        }
    
        if PokedexViewController.pokemon [indexPath.row].id! < 10 {
            cell.numberLabel.text = "#00\(PokedexViewController.pokemon[indexPath.row].id ?? 000)"
        } else if PokedexViewController.pokemon [indexPath.row].id! < 100 {
            cell.numberLabel.text = "#0\(PokedexViewController.pokemon[indexPath.row].id ?? 000)"
        } else {
            cell.numberLabel.text = "#\(PokedexViewController.pokemon[indexPath.row].id ?? 000)"
        }
        
        return cell
    }
}

extension PokedexViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if PokedexViewController.pokemon[indexPath.row].isRegistred {
        self.performSegue(withIdentifier: "goToDetail", sender: PokedexViewController.pokemon[indexPath.row])
        }
    }
}

// MARK: - Service

extension PokedexViewController {
    func fetchPokemon() {
        Service.shared.fetchPokemon { (pokemon) in
            DispatchQueue.main.async {
                PokedexViewController.pokemon = pokemon
                self.collectionView.reloadData()
            }
        }
    }
}
