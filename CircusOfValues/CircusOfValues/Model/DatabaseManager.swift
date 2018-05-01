//
//  DatabaseManager.swift
//  CircusOfValues
//
//  Created by hackeru on 23/10/2017.
//  Copyright © 2017 Fink. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class DatabaseManager: NSObject {
    
    static let manager = DatabaseManager()
    
    private let dbRootRef : DatabaseReference
    var userId : String?{
        get{
            return Auth.auth().currentUser?.uid
        }
    }
    private override init(){
        dbRootRef = Database.database().reference()
        
        super.init()
    }
    
    func storeUserInfo(name : String?, email : String?){
        
        guard let name = name, let email = email, let userId = self.userId else{
            return
        }
        
        let json : [String:Any] = [
            "name":name,
            "email":email
        ]
        
        //var emailstring = email.replacingOccurrences(of: "@", with: "")
        //emailstring = emailstring.replacingOccurrences(of: ".", with: "")
        
        dbRootRef.child("users").child(userId).setValue(json)
        dbRootRef.child("usernames").child(name).setValue(email)
        //dbRootRef.child("emails").child(emailstring).setValue(Date().timeIntervalSince1970)
    }
    
    func storePurchase(productName: String?, productPrice: String?, productImageURL: String?)
    {
        guard let pn = productName, let pp = productPrice, let piu = productImageURL, let userID = self.userId else{
            return
        }
        
        let json: [String:Any] = [
            "name":pn,
            "price":pp,
            "imageURL":piu
        ]
        
        dbRootRef.child("purchases").child(userId!).child(Date().description).setValue(json)
    }
    
    func checkExistmentOfUsername(_ name : String, callback : @escaping (String?)->Void){
        dbRootRef.child("usernames").child(name).observeSingleEvent(of: .value) { (snapshot) in
            guard let value = snapshot.value else{
                callback(nil)
                return
            }
            
            if value is NSNull{
                callback(nil)
                return
            }
            
            callback(snapshot.value as? String)
        }
    }
    
    func checkExistmentOfUser(_ uid : String, callback : @escaping (Bool)->Void){
        dbRootRef.child("users").child(uid).observeSingleEvent(of: .value) { (snapshot) in
            guard let value = snapshot.value else{
                callback(false)
                return
            }
            
            if value is NSNull{
                callback(false)
                return
            }
            print("exists")
            callback(true)
        }
    }
    
}













