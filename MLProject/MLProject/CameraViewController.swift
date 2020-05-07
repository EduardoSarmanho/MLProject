//
//  CameraViewController.swift
//  MLProject
//
//  Created by Lucas Iankowski Corrêa da Silva on 06/05/20.
//  Copyright © 2020 Eduardo Sarmanho. All rights reserved.
//

import UIKit
import AVKit
import Vision

class CameraViewController: UIViewController, AVCaptureVideoDataOutputSampleBufferDelegate{
    
    var pokemonIdentified = ""
    
    let captureSession = AVCaptureSession()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        captureSession.sessionPreset = .photo
        
        guard let captureDevice = AVCaptureDevice.default(for: .video) else { return }
        guard let input = try? AVCaptureDeviceInput(device: captureDevice) else { return }
        captureSession.addInput(input)
        captureSession.startRunning()
        
        let previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        view.layer.addSublayer(previewLayer)
        previewLayer.frame = view.frame
        
        let dataOutput = AVCaptureVideoDataOutput()
        dataOutput.setSampleBufferDelegate(self, queue: DispatchQueue(label: "videoQueue"))
        
        
        captureSession.addOutput(dataOutput)
    }
    
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        guard let pixelBuffer: CVPixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else { return }
        
        guard let model = try? VNCoreMLModel(for: PokemonClassifier_1_copy().model) else { return }
        
        let request = VNCoreMLRequest(model: model)
        { (finishedReq, err) in
//            print(finishedReq.results)
            
            guard let results = finishedReq.results as? [VNClassificationObservation] else { return }
            
            guard let firstObservation = results.first else { return }
            
            if firstObservation.confidence > 0.99 {
                self.pokemonIdentified = firstObservation.identifier
                
                DispatchQueue.main.async {
                    self.performSegue(withIdentifier: "goToDetail", sender: nil)
                }
                
            }
            print(firstObservation.identifier, firstObservation.confidence)
        }
        
        try? VNImageRequestHandler(cvPixelBuffer: pixelBuffer, options: [:]).perform([request])
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToDetail" {
            guard let destination = segue.destination as? PokemonDetailViewController else { return }
            
            var selectedPokemon: Pokemon?
            
            for pokemon in PokedexViewController.pokemon {
                if pokemonIdentified.lowercased() == pokemon.name?.lowercased() {
                    selectedPokemon = pokemon
                }
            }
            captureSession.stopRunning()
            destination.pokemon = selectedPokemon
        }
    }
}
