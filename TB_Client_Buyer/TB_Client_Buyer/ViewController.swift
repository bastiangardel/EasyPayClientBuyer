//
//  ViewController.swift
//  TB_Client_Buyer
//
//  Created by Bastian Gardel on 06.04.16.
//  Copyright © 2016 Bastian Gardel. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

   @IBOutlet weak var LoginB: UIButton!
   
   override func viewDidLoad() {
      super.viewDidLoad()
      // Do any additional setup after loading the view, typically from a nib.
   }

   override func didReceiveMemoryWarning() {
      super.didReceiveMemoryWarning()
      // Dispose of any resources that can be recreated.
   }


   @IBAction func loginAction(sender: AnyObject) {
      
      self.performSegueWithIdentifier("loginSegue", sender: self)
      
      
   }
}

