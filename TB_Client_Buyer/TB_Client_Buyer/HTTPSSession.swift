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
   
   //static let URL : String = "192.168.1.46"
   static let URL : String = Settings.sharedInstance.getParameterString("address_preference")
   
   
   //static let PORT : String = "9000"
   static let PORT : String = Settings.sharedInstance.getParameterString("port_preference")
   
   
   let defaultManager: Alamofire.Manager = {
      let serverTrustPolicies: [String: ServerTrustPolicy] = [
         HTTPSSession.URL : .DisableEvaluation
      ]
      
      let configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
      configuration.HTTPAdditionalHeaders = Alamofire.Manager.defaultHTTPHeaders
      configuration.timeoutIntervalForRequest = 2
      
      return Alamofire.Manager(
         configuration: configuration,
         serverTrustPolicyManager: ServerTrustPolicyManager(policies: serverTrustPolicies)
      )
   }()
   
   
   private override init() {

      super.init()
      
   }
   
   private func completeURL( address : String, port : String, restEndpoint : String) -> String{
      return "https://" + address + ":" + port + restEndpoint;
   }
   
   private func updateCookies(response: Response<NSData, NSError>) {
      if let
         headerFields = response.response?.allHeaderFields as? [String: String],
         URL = response.request?.URL {
         let cookies = NSHTTPCookie.cookiesWithResponseHeaderFields(headerFields, forURL: URL)
         // Set the cookies back in our shared instance. They'll be sent back with each subsequent request.
         defaultManager.session.configuration.HTTPCookieStorage?.setCookies(cookies, forURL: URL, mainDocumentURL: nil)
      }
   }
   
   public func login (let login: String,  let password: String, completion: (success: Bool) -> Void){
   
      let credentials = ["username": login ,"password": password ]
      let headers = [
         "Content-Type": "application/json"
      ]
      
      print("try to login to " + completeURL(HTTPSSession.URL, port: HTTPSSession.PORT, restEndpoint: "/users/auth"))
      
      defaultManager.request(.POST, completeURL(HTTPSSession.URL, port: HTTPSSession.PORT, restEndpoint: "/users/auth"), headers : headers, parameters: credentials , encoding: .JSON)
         .validate()
         .responseData{ Response in
            switch Response.result {
            case .Success:
               self.updateCookies(Response)
               print("login Successful")
               completion(success: true)
            case .Failure(let error):
               print("login fail")
               print(error)
               completion(success: false)
            }
         }
      
   }
   
   public func logout(){
      
      defaultManager.request(.POST, "https://192.168.1.46:9000/users/logout").responseData{ Response in
         print("logout")
      }
      
   }
   
   public func suspend()
   {
   
   }
   
   public func stoptransaction(){
      
   }
}
