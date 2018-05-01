//
//  RegisterController.swift
//  CircusOfValues
//
//  Created by hackeru on 16/10/2017.
//  Copyright © 2017 Fink. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FirebaseDatabase

class RegisterController: UIViewController {
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var error: UILabel!
    @IBAction func returnToLogin(_ sender: Any) {
    }
    @IBAction func submitCred(_ sender: Any) {
        guard validateCred() else{
            return
        }
        
        DatabaseManager.manager.checkExistmentOfUsername(username.text!, callback: { (exist) in
            if exist != nil
            {
                self.error.alpha = 1
                self.error.text = "Username already exists"
                return
            }
            self.createUser()
        })
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboard()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func validateCred() -> Bool
    {
        guard let un = username.text, let pw = password.text, let eml = email.text else
        {
            error.alpha = 1
            error.text = "Missing argument/s"
            return false
        }
        
        if(un.isEmpty || pw.isEmpty || eml.isEmpty)
        {
            error.alpha = 1
            error.text = "Missing argument/s"
            return false
        }
        
        if((un.characters.contains("@")) || (un.characters.contains(" ")))
        {
            error.alpha = 1
            error.text = "Invalid username"
            return false
        }
        
        return true
    }
    func createUser()
    {
        let eml = email.text
        let pw = password.text
        let un = username.text
        
        Auth.auth().createUser(withEmail: eml!, password: pw!) { (user, err) in
            guard user != nil else{
                self.error.text = err?.localizedDescription
                self.error.alpha = 1
                return
            }
            print("user created")
            self.error.alpha = 0
            DatabaseManager.manager.storeUserInfo(name: un, email: eml)
            self.dismiss(animated: false, completion: nil)
        }
        
    }
}
