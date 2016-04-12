//
//  ViewControllerBLE.swift
//  TB_Client_Buyer
//
//  Created by Bastian Gardel on 07.04.16.
//  Copyright © 2016 Bastian Gardel. All rights reserved.
//

import UIKit
import Bluetonium

class ViewControllerBLE: UIViewController {
   
   var value: String = ""
   
   let manager = Manager()
   
   @IBOutlet weak var ScanInProgress: UIActivityIndicatorView!
   
   override func viewDidLoad() {
      super.viewDidLoad()

      
      ScanInProgress.startAnimating()
      
      
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
