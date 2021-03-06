//
//  ViewControllerPayement.swift
//  TB_Client_Buyer
//
//  Created by Bastian Gardel on 11.04.16.
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
import BButton
import MBProgressHUD
import SCLAlertView

// ** Class ViewControllerPayement **
//
// View BLE Scan Controller
//
// Author: Bastian Gardel
// Version: 1.0
class ViewControllerPayement: UIViewController {
   
   var toPass:String!
   
   var httpsSession = HTTPSSession.sharedInstance

   @IBOutlet weak var UID: UITextField!
   
   @IBOutlet weak var ReturnMenuButton: BButton!
   
   @IBOutlet weak var PaiementButton: BButton!
   
   @IBOutlet weak var AmountLabel: UILabel!
   
   @IBOutlet weak var IDLabel: UILabel!
   
   var hud: MBProgressHUD?

   var receipt: ReceiptPayDTO?
   
   
   //View initialisation
    override func viewDidLoad() {
      super.viewDidLoad()
      
      PaiementButton.color = UIColor.bb_purpleBButtonColor()
      PaiementButton.setStyle(BButtonStyle.BootstrapV2)
      PaiementButton.setType(BButtonType.Purple)
      PaiementButton.addAwesomeIcon(FAIcon.FAMoney, beforeTitle: true)
      PaiementButton.enabled = false
      
      ReturnMenuButton.color = UIColor.bb_dangerColorV2()
      ReturnMenuButton.setStyle(BButtonStyle.BootstrapV2)
      ReturnMenuButton.setType(BButtonType.Danger)
      ReturnMenuButton.addAwesomeIcon(FAIcon.FAAngleDoubleLeft, beforeTitle: true)

      
      hud = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
      hud?.labelText = "Receipt Loading in progress"
   
      httpsSession.getReceiptToPay(toPass){
         (success: Bool, errorDescription:String, receiptPayDTO : ReceiptPayDTO?) in
         
         self.hud!.hide(true)
         
         if(success)
         {
            self.receipt = receiptPayDTO
            
            self.AmountLabel.text = " CHF " + String(format: "%.02f",(self.receipt?.amount)!)
            
            self.IDLabel.text = "Receipt ID: " + (self.receipt?.id?.description)!
            
            self.PaiementButton.enabled = true
         }
         else
         {
            let appearance = SCLAlertView.SCLAppearance(
               kTitleFont: UIFont(name: "HelveticaNeue", size: 20)!,
               kTextFont: UIFont(name: "HelveticaNeue", size: 14)!,
               kButtonFont: UIFont(name: "HelveticaNeue-Bold", size: 14)!,
               showCloseButton: false
            )
            
            let alertView = SCLAlertView(appearance: appearance)
            alertView.addButton("Return to menu"){
               self.performSegueWithIdentifier("ReturnMenuSegue", sender: self)
            }
            alertView.showError("Receipt Loading Error", subTitle: errorDescription)
         }
      }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

   //Click on Paiement button handler
   @IBAction func PaiementAction(sender: AnyObject) {
      hud = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
      hud?.labelText = "Paiement in progress"
      
      let appearance = SCLAlertView.SCLAppearance(
         kTitleFont: UIFont(name: "HelveticaNeue", size: 20)!,
         kTextFont: UIFont(name: "HelveticaNeue", size: 14)!,
         kButtonFont: UIFont(name: "HelveticaNeue-Bold", size: 14)!,
         showCloseButton: false
      )
      
      let alertView = SCLAlertView(appearance: appearance)
      alertView.addButton("Return to menu"){
         self.performSegueWithIdentifier("ReturnMenuSegue", sender: self)
      }
      
      httpsSession.PayReceipt(receipt!, UUID: toPass){
         (success: Bool, description: String) in
         
         self.hud!.hide(true)
         
         if(success)
         {
            alertView.showSuccess("Paiement", subTitle: description)
         }
         else
         {
            alertView.showError("Paiement Error", subTitle: description)
         }
      }
   }
   
   //Click on return button handler
   @IBAction func ReturnMenuAction(sender: AnyObject) {
      self.performSegueWithIdentifier("ReturnMenuSegue", sender: self)
   }
}
