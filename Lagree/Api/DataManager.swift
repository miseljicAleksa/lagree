//
//  DataManager.swift
//  KP
//
//  Created by Arsen Leontijevic on 01/11/15.
//  Copyright © 2015 Krivi Put. All rights reserved.
//

import Foundation
import UIKit

class DataManager {
    
    let salonApiUrl:String = "http://lepsha.com/pub/api/salon"
   let userApiUrl:String = "http://bms.lagreefitness.com/api/json"
   //let userApiUrl:String = "http://bms.site/index.php/api/json"
    let privateKey:String = "0e960cb10f6a06933479bccc5db2b814"
    
    var localItems = [[String:AnyObject]]()
    var filteredItems = [[String:AnyObject]]()
    var queryItems = [NSURLQueryItem()]
    var category:String = "all"
    
    var users: [User] = []
    
    var userDef = UserDefaults.standard
    var email: String = ""
    var access_token: String?
    
    init()
    {
        if (userDef.string(forKey: "email") != nil){
            email = userDef.string(forKey: "email")!
        }
        
        access_token = userDef.string(forKey: "access_token")
        
    }
    
    func setDeviceToken(deviceToken: String, completion:@escaping (_ status: String?) -> Void) {
        
        self.queryItems.removeAll()
        
        self.queryItems.append(NSURLQueryItem(name: "email", value: email))
        self.queryItems.append(NSURLQueryItem(name: "action", value: "setDeviceToken"))
        self.queryItems.append(NSURLQueryItem(name: "deviceToken", value: "ios_"+deviceToken))
        
        // Get JSON data
        self.getData(url: self.userApiUrl) {(apiData) -> Void in
            let json = JSON(data: apiData!)
            completion(String(describing: json["status"]))
        }
    }
    
    
    func signin(email:String,password:String, completion:@escaping (_ status: JSON) -> Void) {
        
        self.queryItems.removeAll()
        
        self.queryItems.append(NSURLQueryItem(name: "email", value: email))
        self.queryItems.append(NSURLQueryItem(name: "password", value: password))
        self.queryItems.append(NSURLQueryItem(name: "action", value: "login"))
        
        self.getData(url: self.userApiUrl) {(apiData) -> Void in
            let json = JSON(data: apiData!)
            print(json)
            completion(json)
        }
    }
    
    func getSessions(completion:@escaping (_ status: JSON) -> Void) {
        
        self.queryItems.removeAll()
        
        self.queryItems.append(NSURLQueryItem(name: "action", value: "getSessions"))
        
        let apiData = getTempData()
        let json = JSON(data: apiData)
        completion(json)
    }
    
    func getFavorites(completion:@escaping (_ status: JSON) -> Void) {
        
        self.queryItems.removeAll()
        
        self.queryItems.append(NSURLQueryItem(name: "action", value: "getFavorites"))
        
        let apiData = getTempData()
        let json = JSON(data: apiData)
        completion(json)
    }
    
    func changeEmail(email:String, completion:@escaping (_ status: JSON) -> Void) {
        
        self.queryItems.removeAll()
        self.queryItems.append(NSURLQueryItem(name: "email", value: email))
        self.queryItems.append(NSURLQueryItem(name: "action", value: "changeEmail"))
        
        self.getData(url: self.userApiUrl) {(apiData) -> Void in
            let json = JSON(data: apiData!)
            print(json)
            completion(json)
        }
    }
    
    func register(email:String,fbId:String,password:String,fbat:String, completion:@escaping (_ status: JSON) -> Void) {

        self.queryItems.removeAll()

        self.queryItems.append(NSURLQueryItem(name: "email", value: email))
        self.queryItems.append(NSURLQueryItem(name: "password", value: password))

        self.queryItems.append(NSURLQueryItem(name: "action", value: "signup"))

        self.getData(url: self.userApiUrl) {(apiData) -> Void in
            let json = JSON(data: apiData!)
            print(json)
            completion(json)
        }
    }
    
    
    func updatePersonalInfo(data:[NSURLQueryItem], completion:@escaping (_ status: JSON) -> Void) {
        
        self.queryItems.removeAll()
        self.queryItems = data
        self.queryItems.append(NSURLQueryItem(name: "action", value: "updatePersonalInfo"))
        self.queryItems.append(NSURLQueryItem(name: "access_token", value: self.access_token ?? ""))
        
        self.getData(url: self.userApiUrl) {(apiData) -> Void in
            let json = JSON(data: apiData!)
            print(json)
            completion(json)
        }
    }
    
    func updateEmergencyContact(data:[NSURLQueryItem], completion:@escaping (_ status: JSON) -> Void) {
        
        self.queryItems.removeAll()
        self.queryItems = data
        self.queryItems.append(NSURLQueryItem(name: "action", value: "updateEmergencyContact"))
        self.queryItems.append(NSURLQueryItem(name: "access_token", value: self.access_token ?? ""))
        
        self.getData(url: self.userApiUrl) {(apiData) -> Void in
            let json = JSON(data: apiData!)
            print(json)
            completion(json)
        }
    }
    
    
    func resetPassword(data:[NSURLQueryItem], completion:@escaping (_ status: JSON) -> Void) {
        
        self.queryItems.removeAll()
        self.queryItems = data
        self.queryItems.append(NSURLQueryItem(name: "action", value: "resetPassword"))
        self.queryItems.append(NSURLQueryItem(name: "access_token", value: self.access_token ?? ""))
        
        self.getData(url: self.userApiUrl) {(apiData) -> Void in
            let json = JSON(data: apiData!)
            print(json)
            completion(json)
        }
    }
    
    func getTempData() -> Data
    {
        let apiData = "[{\"name\":\"Sess One\",\"imageUrl\":\"https://images.pexels.com/photos/67636/rose-blue-flower-rose-blooms-67636.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500\"},{\"name\":\"Sess Two\",\"imageUrl\":\"https://images.pexels.com/photos/60597/dahlia-red-blossom-bloom-60597.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260\"}]".data(using: .utf8)
        return apiData!
    }
    
    
    func urlEncode(string: String) -> String
    {
        var newString = string.replacingOccurrences(of: "+", with: "-")
        newString = newString.replacingOccurrences(of: "/", with: "_")
        return newString
    }
    
    
    
    private func createUrl(url: String) -> URL {
        
        let urlComps = NSURLComponents(string: url)!
        
        let version = Bundle.main.infoDictionary?["CFBundleVersion"] as? String
        self.queryItems.append(NSURLQueryItem(name: "version", value: version))
        self.queryItems.append(NSURLQueryItem(name: "platform", value: "ios"))
        var stringArray = [String]()
        stringArray = self.queryItems.compactMap { $0.value! as String }
        let flattenValues = stringArray.joined(separator: "")
        //print(flattenValues)
        let signature = self.urlEncode(string: flattenValues.HMACsha256(key: self.privateKey))
        self.queryItems.append(NSURLQueryItem(name: "key", value: signature))
        
        
        urlComps.queryItems = self.queryItems as [URLQueryItem]?
        return urlComps.url!
    }
    
    private func getData(url: String, success: @escaping ((_ apiData: Data?) -> Void)) {
        
        print(url)
        loadDataFromURL(url: url, completion:{(data, error) -> Void in
         
            if let urlData = data {
                let json = JSON(data: urlData)
                if(json["status"] == "fail")
                {
                    if(json["message"] == "token_expired")
                    {
                        DispatchQueue.main.async(execute: {
                            
                            User.logout()
                            AbstractViewController.goToLoginController()
                        })
                    }
                    //print(json["result"])
                }else{
                    //print(json["message"])
                }
                success(urlData)
            }else{
                let apiData = "{\"status\":\"fail\",\"message\":\"Failed request\",\"result\":[]}".data(using: .utf8)
                success(apiData)
            }
        })
    }
    
    private func loadDataFromURL(url: String, completion:@escaping (_ data: Data?, _ error: NSError?) -> Void) {
        let session = URLSession.shared
        let TopAppURL = self.createUrl(url: url)
        print("loadDataFromURL")
        print(TopAppURL)
        // Use NSURLSession to get data from an NSURL
        let loadDataTask = session.dataTask(with: TopAppURL, completionHandler: { (data, response, error) -> Void in
            if let responseError = error {
                completion(nil, responseError as NSError?)
            } else if let httpResponse = response as? HTTPURLResponse {
                if httpResponse.statusCode != 200 {
                    let statusError = NSError(domain:"com.lepsha", code:httpResponse.statusCode, userInfo:[NSLocalizedDescriptionKey : "HTTP status code has unexpected value."])
                    completion(nil, statusError)
                } else {
                    if data != nil {
                        completion(data, nil)
                    }
                }
            }
        })
        loadDataTask.resume()
    }
}
