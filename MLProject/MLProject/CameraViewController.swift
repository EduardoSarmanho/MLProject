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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let captureSession = AVCaptureSession()
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
        print("aaa")
        guard let pixelBuffer: CVPixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else { return }
        
        let model = VNCoreMLModel(for: PokemonClassifier().model)
        
        let request = VNCoreMLRequest(model: model)
        {(finishedReq, err) in
            print(finishedReq.results)
            
        }
        VNImageRequestHandler(cvPixelBuffer: pixelBuffer, options: [:]).perform([request])
    }
    
}
