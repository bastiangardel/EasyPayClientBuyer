//
//  ViewControllerBLE.swift
//  TB_Client_Buyer
//
//  Created by Bastian Gardel on 07.04.16.
//  Copyright © 2016 Bastian Gardel. All rights reserved.
//

import UIKit
import Bluetonium

class ViewControllerBLE: UIViewController, ManagerDelegate,UIPickerViewDataSource,UIPickerViewDelegate{
   
   var value: String = ""
   
   let manager = Manager()
   
   @IBOutlet weak var ScanInProgress: UIActivityIndicatorView!
   
   @IBOutlet weak var UUIDTable: UIPickerView!
   
   override func viewDidLoad() {
      super.viewDidLoad()

      manager.delegate = self
      UUIDTable.delegate = self
   }
   
   override func viewDidAppear(animated: Bool) {
      super.viewDidAppear(animated)
      
      
      ScanInProgress.startAnimating()
      
      
      manager.startScanForDevices()
      
      while manager.foundDevices.count != 0{
      }
      
      manager.stopScanForDevices()
      
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
   
   // MARK: Manager delegate
   
   func manager(manager: Manager, willConnectToDevice device: Device) {
      
   }
   
   func manager(manager: Manager, didFindDevice device: Device) {
      
   }
   
   func manager(manager: Manager, connectedToDevice device: Device) {
      self.title = "Connected!"
   }
   
   func manager(manager: Manager, disconnectedFromDevice device: Device, retry: Bool) {
      if !retry {
         self.dismissViewControllerAnimated(true, completion: nil)
      } else {
         self.title = "Connecting..."
      }
   }
   
   //MARK: - Delegates and data sources
   //MARK: Data Sources
   func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
      return 1
   }
   
   func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
      return manager.foundDevices.count
   }
   
}
