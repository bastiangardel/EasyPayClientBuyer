//
//  ViewControllerMenu.swift
//  TB_Client_Buyer
//
//  Created by Bastian Gardel on 07.04.16.
//  Copyright © 2016 Bastian Gardel. All rights reserved.
//

import UIKit
import SSBouncyButton

class ViewControllerMenu: UIViewController {

   @IBOutlet weak var QRCodeModButton: SSBouncyButton!
   
   @IBOutlet weak var BLEModeButton: SSBouncyButton!
   
   @IBOutlet weak var LogoutButton: SSBouncyButton!
   
    override func viewDidLoad() {
        super.viewDidLoad()
      
      QRCodeModButton.tintColor = UIColor.blackColor()
      QRCodeModButton.cornerRadius = 5
      QRCodeModButton.backgroundColor = UIColor.turquoiseColor()
      
      BLEModeButton.tintColor = UIColor.blackColor()
      BLEModeButton.cornerRadius = 5
      BLEModeButton.backgroundColor = UIColor.turquoiseColor()
      
      LogoutButton.tintColor = UIColor.blackColor()
      LogoutButton.cornerRadius = 5
      LogoutButton.backgroundColor = UIColor.turquoiseColor()

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
      
      self.performSegueWithIdentifier("LogoutSegue", sender: self)
   }

}
