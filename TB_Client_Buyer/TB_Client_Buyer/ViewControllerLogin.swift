//
//  ViewController.swift
//  TB_Client_Buyer
//
//  Created by Bastian Gardel on 06.04.16.
//  Copyright © 2016 Bastian Gardel. All rights reserved.
//

import UIKit
import KeychainSwift
import FlatUIKit

class ViewControllerLogin: UIViewController {
   
   @IBOutlet weak var LoginTF: UITextField!
   
   @IBOutlet weak var PasswordTF: UITextField!
   
   @IBOutlet weak var SaveLP: UISwitch!
   
   @IBOutlet weak var loginButton: FUIButton!
   
   let keychain = KeychainSwift()
   
   var httpsSession = HTTPSSession.sharedInstance
   
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      loginButton.buttonColor = UIColor.turquoiseColor()
      loginButton.shadowColor = UIColor.greenSeaColor()
      loginButton.shadowHeight = 6.0
      loginButton.cornerRadius = 6.0
      loginButton.setTitleColor(UIColor.blackColor(), forState: .Normal)
      loginButton.setTitleColor(UIColor.blackColor(), forState: .Highlighted)
      
      if ((keychain.get("login")) != nil && (keychain.get("password")) != nil) {
         LoginTF.text = keychain.get("login");
         PasswordTF.text = keychain.get("password")
      }
      
      if keychain.getBool("SaveLP")  != nil {
         SaveLP.setOn(keychain.getBool("SaveLP")!, animated: false)
      }
   }

   override func didReceiveMemoryWarning() {
      super.didReceiveMemoryWarning()
      // Dispose of any resources that can be recreated.
   }


   @IBAction func loginAction(sender: AnyObject) {
      
      keychain.set(SaveLP.on, forKey: "SaveLP");
      
      if(httpsSession.connectionIsOK(LoginTF.text!, password: PasswordTF.text!)){
         if ((keychain.get("login")) == nil && (keychain.get("password")) == nil) {
            if SaveLP.on {
               keychain.set(LoginTF.text!, forKey: "login");
               keychain.set(PasswordTF.text!, forKey: "password");
            }
         }
         else
         {
            if !SaveLP.on {
               keychain.delete("login")
               keychain.delete("password");
            }

         }
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

