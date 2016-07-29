//
//  ViewControllerQR.swift
//  TB_Client_Buyer
//
//  Created by Bastian Gardel on 07.04.16.
//
// Copyright © 2016 Bastian Gardel
//
// Permission is hereby granted, free of charge, to any person obtaining a copy of
// this software and associated documentation files (the "Software"), to deal in
// the Software without restriction, including without limitation the rights to use,
// copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the
// Software, and to permit persons to whom the Software is furnished to do so,
// subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED,
// INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A
// PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
// HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
// OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
// SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

import UIKit

import SwiftQRCode

import BButton

import AVFoundation

// ** Class ViewControllerQR **
//
// View QR Code Reader Controller
//
// Author: Bastian Gardel
// Version: 1.0
class ViewControllerQR: UIViewController {
   
   let scanner = QRCode()
   let avDevice = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)
   
   var value: String = ""
   
   @IBOutlet weak var FlashLight: UISwitch!
   
   @IBOutlet weak var ReturnButton: BButton!
   
   @IBOutlet weak var QRView: UIView!
   
   @IBOutlet weak var QRLoadingIndicator: UIActivityIndicatorView!
   
   //Screen Rotation off
   override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
      return UIInterfaceOrientationMask.Portrait
   }
   
   //View initilialisation
    override func viewDidLoad() {
      super.viewDidLoad()
      
      QRLoadingIndicator.startAnimating()
      
      ReturnButton.color = UIColor.bb_dangerColorV2()
      ReturnButton.setStyle(BButtonStyle.BootstrapV2)
      ReturnButton.setType(BButtonType.Danger)
      ReturnButton.addAwesomeIcon(FAIcon.FAAngleDoubleLeft, beforeTitle: true)
      
      
      // check if the device has torch
      if  avDevice.hasTorch {
         FlashLight.enabled = true
         FlashLight.setOn(false, animated: false)
      }
      
      
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
   //Start scan when the view appear
   override func viewDidAppear(animated: Bool) {
      super.viewDidAppear(animated)
      
      prepareScan()
      
      // start scan
      scanner.startScan()

      QRLoadingIndicator.stopAnimating()
   }
   
   //Action on FlashLightOnOff button handler
   @IBAction func FlashLightOnOff(sender: AnyObject) {
      
      do {
      // unlock your device
      try avDevice.lockForConfiguration()
         
         if avDevice.torchActive {
            avDevice.torchMode = AVCaptureTorchMode.Off
         }
         else
         {
            //avDevice.torchMode = AVCaptureTorchMode.On
            try avDevice.setTorchModeOnWithLevel(1.0)
         }
      
      // unlock your device
      avDevice.unlockForConfiguration()
      }
      catch{}
   }

   //Click on return button handler
   @IBAction func ReturnAction(sender: AnyObject) {
      
      //scanner.stopScan()
      FlashLight.setOn(false, animated: false)
      
      do {
         // unlock your device
         try avDevice.lockForConfiguration()
         
         if avDevice.torchActive {
            avDevice.torchMode = AVCaptureTorchMode.Off
         }
         
         // unlock your device
         avDevice.unlockForConfiguration()
      }
      catch{}
      
      self.performSegueWithIdentifier("QRReturnMenuSegue", sender: self)
      
   }
   
   //Prepare transfer value for next view
   override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
      if (segue.identifier == "QRPayementSegue") {
         let dvc = segue.destinationViewController as! ViewControllerPayement;
         
         dvc.toPass = value
         
      }
   }
   
   //Scan initialisation
   func prepareScan (){
      
      scanner.scanFrame = view.bounds
      scanner.prepareScan(view) { (stringValue) -> () in
         self.value = stringValue;
         self.performSegueWithIdentifier("QRPayementSegue", sender: self)
      }

   }
   
   // Reinitialisation of scan if Rotation
   override func didRotateFromInterfaceOrientation(fromInterfaceOrientation: UIInterfaceOrientation) {
      prepareScan()
      scanner.startScan()
      
      
   }
}
