//
//  ViewControllerPayement.swift
//  TB_Client_Buyer
//
//  Created by Bastian Gardel on 11.04.16.
//  Copyright © 2016 Bastian Gardel. All rights reserved.
//

import UIKit
import BButton
import BButton

class ViewControllerPayement: UIViewController {
   
   var toPass:String!
   
   var httpsSession = HTTPSSession.sharedInstance

   @IBOutlet weak var UID: UITextField!
   
   @IBOutlet weak var ReturnMenuButton: BButton!
   
   @IBOutlet weak var PaiementButton: BButton!
   
   @IBOutlet weak var LoadAmountButton: BButton!
   
    override func viewDidLoad() {
      super.viewDidLoad()
      LoadAmountButton.color = UIColor.bb_successColorV2()
      LoadAmountButton.setStyle(BButtonStyle.BootstrapV2)
      LoadAmountButton.setType(BButtonType.Success)
      LoadAmountButton.addAwesomeIcon(FAIcon.FADownload, beforeTitle: true)
      
      PaiementButton.color = UIColor.bb_purpleBButtonColor()
      PaiementButton.setStyle(BButtonStyle.BootstrapV2)
      PaiementButton.setType(BButtonType.Purple)
      PaiementButton.addAwesomeIcon(FAIcon.FAMoney, beforeTitle: true)
      
      
      
      ReturnMenuButton.color = UIColor.bb_dangerColorV2()
      ReturnMenuButton.setStyle(BButtonStyle.BootstrapV2)
      ReturnMenuButton.setType(BButtonType.Danger)
      ReturnMenuButton.addAwesomeIcon(FAIcon.FAAngleDoubleLeft, beforeTitle: true)

      UID.text = toPass;
        // Do any additional setup after loading the view.
      
   
      
//      let priority = DISPATCH_QUEUE_PRIORITY_DEFAULT
//      dispatch_async(dispatch_get_global_queue(priority, 0)) {
//         
//         while(true){
//            print("test");
//            usleep(1000*1000)
//         }
//      }
      
      
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

   @IBAction func ReturnMenuAction(sender: AnyObject) {
      self.performSegueWithIdentifier("ReturnMenuSegue", sender: self)
   }
}
