//
//  ViewControllerPayement.swift
//  TB_Client_Buyer
//
//  Created by Bastian Gardel on 11.04.16.
//  Copyright © 2016 Bastian Gardel. All rights reserved.
//

import UIKit

class ViewControllerPayement: UIViewController {
   
   var toPass:String!
   
   var httpsSession = HTTPSSession.sharedInstance

   @IBOutlet weak var UID: UITextField!
   
    override func viewDidLoad() {
        super.viewDidLoad()

      UID.text = toPass;
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

   @IBAction func ReturnMenuAction(sender: AnyObject) {
      self.performSegueWithIdentifier("ReturnMenuSegue", sender: self)
   }
}
