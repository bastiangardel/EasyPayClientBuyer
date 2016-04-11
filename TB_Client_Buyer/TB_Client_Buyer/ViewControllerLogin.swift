//
//  ViewController.swift
//  TB_Client_Buyer
//
//  Created by Bastian Gardel on 06.04.16.
//  Copyright © 2016 Bastian Gardel. All rights reserved.
//

import UIKit

class ViewControllerLogin: UIViewController {
   
   @IBOutlet weak var LoginTF: UITextField!
   
   @IBOutlet weak var PasswordTF: UITextField!
   
   override func viewDidLoad() {
      super.viewDidLoad()
      // Do any additional setup after loading the view, typically from a nib.
   }

   override func didReceiveMemoryWarning() {
      super.didReceiveMemoryWarning()
      // Dispose of any resources that can be recreated.
   }


   @IBAction func loginAction(sender: AnyObject) {
      
      if(LoginTF.text == "test@test.com" && PasswordTF.text == "test"){
         self.performSegueWithIdentifier("loginSegue", sender: self)
      }
      else
      {
         let alertController = UIAlertController(title: "Login", message:
            "Login Fail", preferredStyle: UIAlertControllerStyle.Alert)
         alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: nil))
         self.presentViewController(alertController, animated: true, completion: nil)
      }
      
   }

}

