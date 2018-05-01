//
//  MainController.swift
//  CircusOfValues
//
//  Created by hackeru on 19/10/2017.
//  Copyright © 2017 Fink. All rights reserved.
//

import Foundation
import UIKit
import FirebaseAuth

class MainController: UIViewController {
    
    @IBAction func signOut(_ sender: Any) {
        do
        {
            try? Auth.auth().signOut()
        }
        catch
        {
            print("Error at logout")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
