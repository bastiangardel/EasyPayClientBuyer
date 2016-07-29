//
//  ViewControllerMenu.swift
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
import BButton

// ** Class ViewControllerMenu **
//
// View Menu Controller
//
// Author: Bastian Gardel
// Version: 1.0
class ViewControllerMenu: UIViewController {

   @IBOutlet weak var QRCodeModButton: BButton!
   
   @IBOutlet weak var BLEModeButton: BButton!
   
   @IBOutlet weak var LogoutButton: BButton!
   
   //View initialisation
    override func viewDidLoad() {
        super.viewDidLoad()
      
      QRCodeModButton.color = UIColor.bb_primaryColorV2()
      QRCodeModButton.setStyle(BButtonStyle.BootstrapV2)
      QRCodeModButton.setType(BButtonType.Primary)
      QRCodeModButton.addAwesomeIcon(FAIcon.FAQrcode, beforeTitle: false)
      
      BLEModeButton.color = UIColor.bb_primaryColorV2()
      BLEModeButton.setStyle(BButtonStyle.BootstrapV2)
      BLEModeButton.setType(BButtonType.Primary)
      BLEModeButton.addAwesomeIcon(FAIcon.FABluetooth, beforeTitle: false)
      
      LogoutButton.color = UIColor.bb_dangerColorV2()
      LogoutButton.setStyle(BButtonStyle.BootstrapV2)
      LogoutButton.setType(BButtonType.Danger)
      LogoutButton.addAwesomeIcon(FAIcon.FASignOut, beforeTitle: false)
      

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
   //Click on QR Mode button handler
   @IBAction func QRAction(sender: AnyObject) {
      
      self.performSegueWithIdentifier("QRSegue", sender: self)
      
   }

   //Click on BLE Mode button handler
   @IBAction func BLEAction(sender: AnyObject) {
      
      self.performSegueWithIdentifier("BLESegue", sender: self)
   }

   //Click on logout button handler
   @IBAction func LogoutAction(sender: AnyObject) {
      let httpsSession = HTTPSSession.sharedInstance
      
      httpsSession.logout()
      
      self.performSegueWithIdentifier("LogoutSegue", sender: self)
   }

}
