//
//  QRScannerController.swift
//  QRCodeReader
//
//  Created by Simon Ng on 13/10/2016.
//  Copyright © 2016 AppCoda. All rights reserved.
//

import UIKit
import AVFoundation

class QRScannerController: UIViewController {

    @IBOutlet var messageLabel:UILabel!
    @IBOutlet var topbar: UIView!
    
    var captureSession = AVCaptureSession()
    var videoPreviewLayer: AVCaptureVideoPreviewLayer?
    var qrCodeFrameView: UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Get the back-facing camera for capturing videos
        // DiscoverySession is designed to find all available capture devices matching a specific device type
        // We specify to retrieve the device that supports videos
        let deviceDiscoverySession = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInDualCamera], mediaType: AVMediaType.video, position: .back)
        
        // To perform a real-time capture, we use AVCaptureSession (declared above) and add the input of the video capture device (rear-facing camera)
        // The AVCaptureSession is used to coordinate the flow of data from the video capture device to our output
        guard let captureDevice = deviceDiscoverySession.devices.first else {
            print("Failed to get the camera device")
            return
        }
        
        
        do {
            // Get an instance of AVCaptureDeviceInput using the capture device (the camera)
            let input = try AVCaptureDeviceInput(device: captureDevice)
            
            // Add the AV capture device input to the capture session
            captureSession.addInput(input)
            
            // Initialize an AVCaptureMetadataOutput object and set it as the output device to the capture session.
            let captureMetadataOutput = AVCaptureMetadataOutput()
            captureSession.addOutput(captureMetadataOutput)
            
            // Set the delegate and use the default dispatch queue to execute the callback
            // When new metadata objects are captured, they are forwarded to the delegate object for further processing
            // We specify the dispatch queue where we execute the delegate's methods.
            captureMetadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            
            // We tell the app we're interested in QR metadata object types
            captureMetadataOutput.metadataObjectTypes = [AVMetadataObject.ObjectType.qr]
            
            // Now, we'll display the video captured by the device's camera on screen
            videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
            videoPreviewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
            videoPreviewLayer?.frame = view.layer.bounds
            view.layer.addSublayer(videoPreviewLayer!)
            
            // Move the message label and top bar to the front
            view.bringSubview(toFront: messageLabel)
            view.bringSubview(toFront: topbar)
            
            
            // Start the video capture
            captureSession.startRunning()
            
            
            // Initialize QR code frame to highlight the QR code
            qrCodeFrameView = UIView()
            
            if let qrCodeFrameView = qrCodeFrameView {
                qrCodeFrameView.layer.borderColor = UIColor.green.cgColor
                qrCodeFrameView.layer.borderWidth = 2
                view.addSubview(qrCodeFrameView)
                view.bringSubview(toFront: qrCodeFrameView)
            }
            
            
        } catch {
            // Simply print any errors and return
            print(error)
            return
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

// MARK: AVCaptureMetadataOutputObjectsDelegate extension
extension QRScannerController: AVCaptureMetadataOutputObjectsDelegate {
    // Parse the QR code (i.e. the metadata)
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        // Check if the metadataObjects array is not nil and it contains at least one object
        if metadataObjects.count == 0 {
            qrCodeFrameView?.frame = CGRect.zero
            messageLabel.text = "No QR code is detected"
            return
        }
        
        // Get the metadata object
        let metadataObj = metadataObjects.first as! AVMetadataMachineReadableCodeObject
        
        // Ensure we have scanned a QR code
        if metadataObj.type == AVMetadataObject.ObjectType.qr {
            
            // Convert the metadata object's visual properties to layer coordinates
            let barcodeObject = videoPreviewLayer?.transformedMetadataObject(for: metadataObj)
            
            // From that, we can find the bounds for the green box
            qrCodeFrameView?.frame = barcodeObject!.bounds
            
            // Decode the QR code into human-readable text0
            if metadataObj.stringValue != nil {
                messageLabel.text = metadataObj.stringValue
            }
        }
    }
}
