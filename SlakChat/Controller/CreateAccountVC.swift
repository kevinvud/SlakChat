//
//  CreateAccountVC.swift
//  SlakChat
//
//  Created by PoGo on 10/7/17.
//  Copyright © 2017 PoGo. All rights reserved.
//

import UIKit

class CreateAccountVC: UIViewController {

    @IBOutlet weak var userNameTxt: UITextField!
    
    @IBOutlet weak var emailTxt: UITextField!
    
    @IBOutlet weak var passTxt: UITextField!
    
    @IBOutlet weak var userImg: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
           

    }
    
    @IBAction func closePressed(_ sender: Any) {
        
        performSegue(withIdentifier: UNWIND, sender: nil)
    }

    @IBAction func createAccntPressed(_ sender: Any) {
        
        guard let email = emailTxt.text , emailTxt.text != "" else{ return }
        guard let pass = passTxt.text, passTxt.text != "" else{return}
        AutheService.instance.registerUser(email: email, password: pass) { (success) in
            if success{
                print("regustered user!")
            }
        }
    }

    @IBAction func pickAvatarPressed(_ sender: Any) {
    }
    
    @IBAction func pickBGColorPressed(_ sender: Any) {
    }
}
