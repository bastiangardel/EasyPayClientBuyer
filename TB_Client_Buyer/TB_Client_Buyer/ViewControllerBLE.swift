//
//  ViewControllerBLE.swift
//  TB_Client_Buyer
//
//  Created by Bastian Gardel on 07.04.16.
//  Copyright © 2016 Bastian Gardel. All rights reserved.
//

import UIKit
import BLEHelper

class ViewControllerBLE: UIViewController {
   
   var value: String = ""
   
   
   let bleHelper = BLECentralHelper()

    override func viewDidLoad() {
        super.viewDidLoad()

      bleHelper.scan(1.0, serviceUUID: nil) { (devices) -> (Void) in
         
      }
    }

   @IBAction func ReturnMenuAction(sender: AnyObject) {
      self.performSegueWithIdentifier("BLEReturnMenuSegue", sender: self)
   }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
      if (segue.identifier == "BLEPayementSegue") {
         let svc = segue.destinationViewController as! ViewControllerPayement;
         
         svc.toPass = value
         
      }
   }

}
