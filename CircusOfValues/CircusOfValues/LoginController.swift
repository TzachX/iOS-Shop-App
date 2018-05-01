//
//  ViewController.swift
//  CircusOfValues
//
//  Created by hackeru on 16/10/2017.
//  Copyright © 2017 Fink. All rights reserved.
//

import UIKit
import AVFoundation
import FirebaseAuth

class LoginController: UIViewController {
    @IBOutlet weak var LoginButton: UIButton!
    @IBOutlet weak var error: UILabel!
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    
    @IBAction func startLogin(_ sender: Any) {
        if(username.text?.characters.contains("@"))!
        {
            self.doLogin(username.text)
            return
        }
        
        DatabaseManager.manager.checkExistmentOfUsername(username.text!, callback: { (exist) in
            self.doLogin(exist)
        })
        return
    }
    
    func doLogin(_ email: String?) {
        guard let eml = email else{
            self.error.alpha = 1
            self.error.text = "Error with username"
            return
        }
        
        Auth.auth().signIn(withEmail: (email)!, password: password.text!) { (user, err) in
            if err != nil
            {
                self.error.alpha = 1
                self.error.text = err.debugDescription
                return
            }
            print("login success")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        LoginButton.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.bold)
        playSound()
        self.hideKeyboard()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    var player: AVAudioPlayer?
    
    func playSound() {
        guard let url = Bundle.main.url(forResource: "Welcome", withExtension: "mp3") else {
            print ("didn't find file")
            return }
        
        do {
            /* The following line is required for the player to work on iOS 11. Change the file type accordingly*/
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
            
            /* iOS 10 and earlier require the following line:
             player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileTypeMPEGLayer3) */
            
            guard let player = player else { return }
            
            player.play()
            
        } catch let error {
            print(error.localizedDescription)
        }
    }

}

