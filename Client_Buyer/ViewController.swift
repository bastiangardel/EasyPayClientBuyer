//
//  ViewController.swift
//  Client_Buyer
//
//  Created by Bastian Gardel on 15.03.16.
//  Copyright © 2016 Bastian Gardel. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

   @IBOutlet weak var text: UITextView!
   
   @IBOutlet weak var web: UIWebView!
   
   override func viewDidLoad() {
      super.viewDidLoad()
      // Do any additional setup after loading the view, typically from a nib.
      
      self.text.editable = false;
      
      
      Alamofire.request(.GET, "https://alldebrid.fr/")
         .responseString { response in
            print("Success: \(response.result.isSuccess)")
            print("Response String: \(response.result.value)")
            
            self.text.text = response.result.value;
            
            let url = NSURL (string: "https://alldebrid.fr/");
            let requestObj = NSURLRequest(URL: url!);
            self.web.loadRequest(requestObj);
      }
      
      
   }

   override func didReceiveMemoryWarning() {
      super.didReceiveMemoryWarning()
      // Dispose of any resources that can be recreated.
   }


}