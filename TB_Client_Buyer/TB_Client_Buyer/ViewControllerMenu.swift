//
//  ViewControllerMenu.swift
//  TB_Client_Buyer
//
//  Created by Bastian Gardel on 07.04.16.
//  Copyright © 2016 Bastian Gardel. All rights reserved.
//

import UIKit

class ViewControllerMenu: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

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
