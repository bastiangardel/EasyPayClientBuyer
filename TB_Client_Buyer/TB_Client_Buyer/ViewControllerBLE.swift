//
//  ViewControllerBLE.swift
//  TB_Client_Buyer
//
//  Created by Bastian Gardel on 07.04.16.
//  Copyright © 2016 Bastian Gardel. All rights reserved.
//

import UIKit
import Bluetonium
import FlatUIKit

class ViewControllerBLE: UIViewController, ManagerDelegate,UIPickerViewDataSource,UIPickerViewDelegate{
   
   var value: String = ""
   
   let manager = Manager()
   
   @IBOutlet weak var ScanInProgress: UIActivityIndicatorView!
   
   @IBOutlet weak var UUIDTable: UIPickerView!
   
   @IBOutlet weak var GoToPaiement: FUIButton!
   
   @IBOutlet weak var ReturnButton: FUIButton!
   
   @IBOutlet weak var InformationLabel: UILabel!
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      GoToPaiement.buttonColor = UIColor.turquoiseColor()
      GoToPaiement.shadowColor = UIColor.greenSeaColor()
      GoToPaiement.shadowHeight = 3.0
      GoToPaiement.cornerRadius = 6.0
      GoToPaiement.setTitleColor(UIColor.blackColor(), forState: .Normal)
      GoToPaiement.setTitleColor(UIColor.blackColor(), forState: .Highlighted)
      
      ReturnButton.buttonColor = UIColor.turquoiseColor()
      ReturnButton.shadowColor = UIColor.greenSeaColor()
      ReturnButton.shadowHeight = 3.0
      ReturnButton.cornerRadius = 6.0
      ReturnButton.setTitleColor(UIColor.blackColor(), forState: .Normal)
      ReturnButton.setTitleColor(UIColor.blackColor(), forState: .Highlighted)
      
      manager.delegate = self
      UUIDTable.delegate = self
   }
   
   override func viewDidAppear(animated: Bool) {
      super.viewDidAppear(animated)
      
      if !manager.bluetoothEnabled {
         let alertController = UIAlertController(title: "Erreur", message:
            "Bluetooth not enable !!", preferredStyle: UIAlertControllerStyle.Alert)
         alertController.addAction(UIAlertAction(title: "Return to menu", style: UIAlertActionStyle.Default, handler:
            {
               [unowned self] (action) -> Void in
               self.performSegueWithIdentifier("BLEReturnMenuSegue", sender: self)
            }))
         self.presentViewController(alertController, animated: true, completion: nil)
      }
      else
      {
         manager.startScanForDevices()
         ScanInProgress.startAnimating()
      }
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
   
   @IBAction func ReturnMenuAction(sender: AnyObject) {
      self.performSegueWithIdentifier("BLEReturnMenuSegue", sender: self)
   }
   
   @IBAction func GoToPaiementAction(sender: AnyObject) {
      value = Array(manager.foundDevices)[UUIDTable.selectedRowInComponent(0)].peripheral.identifier.UUIDString
      
      self.performSegueWithIdentifier("BLEPayementSegue", sender: self)
   }
   
   //Manager delegate
   
   func manager(manager: Manager, willConnectToDevice device: Device) {
      
   }
   
   func manager(manager: Manager, didFindDevice device: Device) {
      UUIDTable.reloadAllComponents()
      
      GoToPaiement.enabled = true
      
      InformationLabel.text = "Choose the check-out ID"
      
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
   
   //PickerView delegate
   func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
      return 1
   }
   
   func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
      return manager.foundDevices.count
   }
   
   func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
      
      if Array(manager.foundDevices)[row].peripheral.name != nil {
         return Array(manager.foundDevices)[row].peripheral.name
      }
      
      return Array(manager.foundDevices)[row].peripheral.identifier.UUIDString
   }
   
}
