//
//  ViewControllerQR.swift
//  TB_Client_Buyer
//
//  Created by Bastian Gardel on 07.04.16.
//  Copyright © 2016 Bastian Gardel. All rights reserved.
//

import UIKit

import SwiftQRCode

import AVFoundation

class ViewControllerQR: UIViewController {
   
   let scanner = QRCode()
   let avDevice = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)
   
   var value: String = ""
   
   @IBOutlet weak var FlashLight: UISwitch!
   
//   override func shouldAutorotate() -> Bool {
//      return false;
//   }
   
   override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
      return UIInterfaceOrientationMask.Portrait
   }
   
    override func viewDidLoad() {
      super.viewDidLoad()
      
      
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
   
   override func viewDidAppear(animated: Bool) {
      super.viewDidAppear(animated)
      
      prepareScan()
      
      // start scan
      scanner.startScan()


   }
   
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
   
   override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
      if (segue.identifier == "QRPayementSegue") {
         let dvc = segue.destinationViewController as! ViewControllerPayement;
         
         dvc.toPass = value
         
      }
   }
   
   func prepareScan (){
      
      scanner.scanFrame = view.bounds
      scanner.prepareScan(view) { (stringValue) -> () in
         self.value = stringValue;
         self.performSegueWithIdentifier("QRPayementSegue", sender: self)
      }

   }
   
   override func didRotateFromInterfaceOrientation(fromInterfaceOrientation: UIInterfaceOrientation) {
      prepareScan()
      scanner.startScan()
   }
}
