//
//  QRViewController.swift
//  MyMovieFinal
//
//  Created by Mickey English on 30/03/2018.
//  Copyright © 2018 Andrei Nagy. All rights reserved.
//

import UIKit
import AVFoundation

class QRViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
    
    // display video to the user
    var video = AVCaptureVideoPreviewLayer()

    @IBOutlet weak var QRSquare: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // create session
        let sessionUser = AVCaptureSession()
        
        // using phones hardware to capture device and registering it
        let captureDevice = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo)
        
        
        do {
            let deviceInput = try? AVCaptureDeviceInput(device: captureDevice)
            sessionUser.addInput(deviceInput)
            
        }
        catch
        {
           print("Error")
        }
        
        // output
        let deviceOutput = AVCaptureMetadataOutput()
        sessionUser.addOutput(deviceOutput)
        
        deviceOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
        
        
        // getting the QR code output can add barcode as well
        deviceOutput.metadataObjectTypes = [AVMetadataObjectTypeQRCode]
        
        
        video = AVCaptureVideoPreviewLayer(session: sessionUser)
        // video layer filling the screen
        video.frame = view.layer.bounds
        view.layer.addSublayer(video)
        
        self.view.bringSubview(toFront: QRSquare)
        
        
        // start the capture
        sessionUser.startRunning()
        
    }
    
    
    // process the output
    func captureOutput(_ captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [Any]!, from connection: AVCaptureConnection!) {
        
        if metadataObjects != nil && metadataObjects.count != 0
        {
           // Returns the error corrected data decoded into a human-readable string.
            if let object = metadataObjects[0] as? AVMetadataMachineReadableCodeObject
            {
                // if type == to qr code dislapy an alert to the user
                if object.type == AVMetadataObjectTypeQRCode
                {
                    let alert = UIAlertController(title: "QR Code", message: object.stringValue, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Retake", style: .default, handler: nil))
                    alert.addAction(UIAlertAction(title: "Copy", style: .default, handler: { (nil) in
                        UIPasteboard.general.string = object.stringValue
                    }))
                    
                    present(alert, animated: true, completion: nil)
                }
            }
        }
    }

        
        
        

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
}
    

