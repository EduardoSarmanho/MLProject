//
//  PokemonDetailViewController.swift
//  MLProject
//
//  Created by Gustavo Travassos on 30/04/20.
//  Copyright © 2020 Eduardo Sarmanho. All rights reserved.
//

import AVFoundation
import UIKit

class PokemonDetailViewController: UIViewController {

    var pokemon: Pokemon?
    var isSiriAllowedToSpeak = true
    
    @IBOutlet weak var image: UIImageView!
    var text: String?
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var number: UILabel!
    @IBOutlet weak var pokemonDescription: UITextView!
    @IBOutlet weak var height: UILabel!
    @IBOutlet weak var weight: UILabel!
    @IBOutlet weak var micButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let pokemon = pokemon else { return }
        
        name.text = pokemon.name?.capitalized
        image.image = pokemon.image
        pokemonDescription.text = pokemon.description
        weight.text = "\(pokemon.weight ?? -1)"
        height.text = "\(pokemon.height ?? -1)"
        
        if pokemon.id ?? -1 < 10 {
            number.text = "#00\(pokemon.id ?? -1)"
        } else if pokemon.id ?? -1 < 10 {
            number.text = "#0\(pokemon.id ?? -1)"
        } else {
            number.text = "#\(pokemon.id ?? -1)"
        }
        
        if isSiriAllowedToSpeak {
            micButton.setImage(UIImage(systemName: "mic.fill"), for: .normal)
            makeSiriTalk()
        } else {
            micButton.setImage(UIImage(systemName: "mic.slash.fill"), for: .normal)
        }
    }
    
    func makeSiriTalk() {
        guard let pokemon = pokemon else { return }
        let synthesizer1 = AVSpeechSynthesizer()
        let pokemonName = AVSpeechUtterance(string: pokemon.name ?? "Error")
        pokemonName.rate = 0.5
        pokemonName.voice = AVSpeechSynthesisVoice(language: "en-UK")
        synthesizer1.speak(pokemonName)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
            let synthesizer2 = AVSpeechSynthesizer()
            let pokemonDesc = AVSpeechUtterance(string: pokemon.description ?? "Error")
            pokemonDesc.rate = 0.5
            pokemonDesc.voice = AVSpeechSynthesisVoice(language: "en-UK")
            synthesizer2.speak(pokemonDesc)
        }
    }
    
    @IBAction func toggleSiri(_ sender: Any) {
        if isSiriAllowedToSpeak {
            micButton.setImage(UIImage(systemName: "mic.fill"), for: .normal)
            makeSiriTalk()
        }
        else {
            micButton.setImage(UIImage(systemName: "mic.slash.fill"), for: .normal)
        }
        isSiriAllowedToSpeak = !isSiriAllowedToSpeak
    }


}
