//
//  RootController.swift
//  CircusOfValues
//
//  Created by hackeru on 19/10/2017.
//  Copyright © 2017 Fink. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FirebaseAuth

class RootController: UIViewController{
    override func viewDidLoad() {
        super.viewDidLoad()
        Timer.scheduledTimer(timeInterval: 15, target: self, selector: #selector(validateToken), userInfo: nil, repeats: true)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            self.startListenToAuth()
        }
    }
    
    @objc func validateToken(){
        
        Auth.auth().currentUser?.getIDTokenForcingRefresh(true, completion: { (token, err) in

            if err != nil{
                try? Auth.auth().signOut()
            }
            
        })
    }
    
    func startListenToAuth(){
        Auth.auth().addStateDidChangeListener { (auth, user) in
            if user != nil
            {
                self.displayFlow(with: "Main")
            }
            else {
                self.displayFlow(with: "LoginController")
            }
        }
    }
    
    func displayFlow(with identifier : String){
        guard Thread.isMainThread else{
            DispatchQueue.main.async {
                self.displayFlow(with: identifier)
            }
            return
        }
        
        if let count = navigationController?.viewControllers.count, count > 1{
            self.navigationController?.popToRootViewController(animated: false)
        }
        
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: identifier){
            self.navigationController?.pushViewController(vc, animated: true)
        } else {
            fatalError("no vc found with identifier " + identifier)
        }
        
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
