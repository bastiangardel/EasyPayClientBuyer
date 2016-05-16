//
//  ViewController.swift
//  TB_Client_Buyer
//
//  Created by Bastian Gardel on 06.04.16.
//  Copyright © 2016 Bastian Gardel. All rights reserved.
//

import UIKit
import KeychainSwift
import BButton

class ViewControllerLogin: UIViewController {
   
   @IBOutlet weak var LoginTF: UITextField!
   
   @IBOutlet weak var PasswordTF: UITextField!
   
   @IBOutlet weak var SaveLP: UISwitch!
   
   @IBOutlet weak var loginButton: BButton!
   
   let keychain = KeychainSwift()
   
   var httpsSession = HTTPSSession.sharedInstance
   
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      loginButton.color = UIColor.bb_successColorV2()
      loginButton.setStyle(BButtonStyle.BootstrapV2)
      loginButton.setType(BButtonType.Success)
      loginButton.addAwesomeIcon(FAIcon.FASignIn, beforeTitle: false)
      
      
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
      
      loginButton.enabled = false
      
      httpsSession.login(LoginTF.text!, password: PasswordTF.text!){
         (success: Bool) in
         
         if(success)
         {
            if ((self.keychain.get("login")) == nil && (self.keychain.get("password")) == nil) {
               if self.SaveLP.on {
                  self.keychain.set(self.LoginTF.text!, forKey: "login");
                  self.keychain.set(self.PasswordTF.text!, forKey: "password");
               }
            }
            else
            {
               if !self.SaveLP.on {
                  self.keychain.delete("login")
                  self.keychain.delete("password");
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
            
            self.loginButton.enabled = true
         }
         
      }
      

   }

}

