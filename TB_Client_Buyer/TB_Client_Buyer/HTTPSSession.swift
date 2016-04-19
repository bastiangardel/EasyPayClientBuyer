//
//  HTTPSSession.swift
//  TB_Client_Buyer
//
//  Created by Bastian Gardel on 19.04.16.
//  Copyright © 2016 Bastian Gardel. All rights reserved.
//

import UIKit

public class HTTPSSession: NSObject {
   
   static let sharedInstance = HTTPSSession()
   
   public var URL : String?
   public var cookies : NSHTTPCookie?
   
   public var login : String?
   public var password : String?
   
   public var active : Bool = false
   
   
   private override init() {

   }

}
