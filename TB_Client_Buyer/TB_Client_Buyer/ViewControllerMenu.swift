//
//  ViewControllerMenu.swift
//  TB_Client_Buyer
//
//  Created by Bastian Gardel on 07.04.16.
//  Copyright © 2016 Bastian Gardel. All rights reserved.
//

import UIKit
import BButton

class ViewControllerMenu: UIViewController {

   @IBOutlet weak var QRCodeModButton: BButton!
   
   @IBOutlet weak var BLEModeButton: BButton!
   
   @IBOutlet weak var LogoutButton: BButton!
   
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
    
   @IBAction func QRAction(sender: AnyObject) {
      
      self.performSegueWithIdentifier("QRSegue", sender: self)
      
   }

   @IBAction func BLEAction(sender: AnyObject) {
      
      self.performSegueWithIdentifier("BLESegue", sender: self)
   }

   
   @IBAction func LogoutAction(sender: AnyObject) {
      let httpsSession = HTTPSSession.sharedInstance
      
      httpsSession.logout()
      
      self.performSegueWithIdentifier("LogoutSegue", sender: self)
   }

}
