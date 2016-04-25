//
//  HTTPSSession.swift
//  TB_Client_Buyer
//
//  Created by Bastian Gardel on 19.04.16.
//  Copyright © 2016 Bastian Gardel. All rights reserved.
//

import UIKit
import Alamofire

public class HTTPSSession: NSObject {
   
   static let sharedInstance = HTTPSSession()
   
   private let URL : String = "https://test.com"
   public var cookies : NSHTTPCookie?
   
   public var login : String?
   public var password : String?
   
   public var active : Bool = false
   
   
   private override init() {

   }
   
   public func connectionIsOK (let login: String,  let password: String) -> Bool{
   
      active = true
      
      return login == "test@test.com" && password == "test";
   }
   
   public func disconnect(){
      
   }
   
   public func stoptransaction(){
      
   }

}
