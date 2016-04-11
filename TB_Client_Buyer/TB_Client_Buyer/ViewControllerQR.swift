//
//  ViewControllerQR.swift
//  TB_Client_Buyer
//
//  Created by Bastian Gardel on 07.04.16.
//  Copyright © 2016 Bastian Gardel. All rights reserved.
//

import UIKit

import SwiftQRCode

class ViewControllerQR: UIViewController {
   
   let scanner = QRCode()
   
   var value: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
      
      super.viewDidLoad()
      
      scanner.prepareScan(view) { (stringValue) -> () in
         self.value = stringValue;
         self.performSegueWithIdentifier("QRPayementSegue", sender: self)
      }
      scanner.scanFrame = view.bounds
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
   override func viewDidAppear(animated: Bool) {
      super.viewDidAppear(animated)
      
      // start scan
      scanner.startScan()
   }
   
   override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
      if (segue.identifier == "QRPayementSegue") {
         let dvc = segue.destinationViewController as! ViewControllerPayement;
         
         dvc.toPass = value
         
      }
   }

}
