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
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    var avatarName = "profileDefault"
    var avatarColor = "[0.5,0.5,0.5,1]"
    var bgColor : UIColor?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
           

    }
    override func viewDidAppear(_ animated: Bool) {
        if UserDataService.instance.avatarName != ""{
            userImg.image = UIImage(named: UserDataService.instance.avatarName)
            avatarName = UserDataService.instance.avatarName
            //make lightgray background color for light image so it is easily to see
            if avatarName.contains("light") && bgColor == nil{
                userImg.backgroundColor = UIColor.lightGray
            }
            
        }
    }
    @IBAction func closePressed(_ sender: Any) {
        
        performSegue(withIdentifier: UNWIND, sender: nil)
    }

    @IBAction func createAccntPressed(_ sender: Any) {
        spinner.isHidden = false
        spinner.startAnimating()
        
        guard let name = userNameTxt.text , userNameTxt.text != "" else{ return }
        guard let email = emailTxt.text , emailTxt.text != "" else{ return }
        guard let pass = passTxt.text, passTxt.text != "" else{return}
        
        AuthService.instance.registerUser(email: email, password: pass) { (success) in
            if success{
                print("registered user!")
                AuthService.instance.loginUser(email: email, password: pass, completion: { (success) in
                    if success{
                        print("logged in user~", AuthService.instance.authToken)
                        AuthService.instance.createUser(name: name, email: email, avatarName: self.avatarName, avatarColor: self.avatarColor, completion: { (success) in
                            if success{
                                self.spinner.isHidden = true
                                self.spinner.stopAnimating()
                                print("Success")
                                print(UserDataService.instance.name, UserDataService.instance.avatarName)
                                self.performSegue(withIdentifier: UNWIND, sender: nil)
                                NotificationCenter.default.post(name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
                                
                            }
                        })
                    }
                })
            }
        }
    }

    @IBAction func pickAvatarPressed(_ sender: Any) {
        
        performSegue(withIdentifier: TO_AVATAR_PICKER, sender: nil)
    }
    
    @IBAction func pickBGColorPressed(_ sender: Any) {
        let r = CGFloat(arc4random_uniform(255)) / 255
        let g = CGFloat(arc4random_uniform(255)) / 255
        let b = CGFloat(arc4random_uniform(255)) / 255
        
        bgColor = UIColor(red: r, green: g, blue: b, alpha: 1)
        UIView.animate(withDuration: 0.2){
            self.userImg.backgroundColor = self.bgColor
        }
        self.userImg.backgroundColor = bgColor
    }
    
    //change textfield placeholders to purple color
    func setupView(){
        spinner.isHidden = true
        userNameTxt.attributedPlaceholder = NSAttributedString(string: "Username", attributes: [NSAttributedStringKey.foregroundColor: smackPurplePlaceHolder])
        passTxt.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [NSAttributedStringKey.foregroundColor: smackPurplePlaceHolder])
        emailTxt.attributedPlaceholder = NSAttributedString(string: "Email", attributes: [NSAttributedStringKey.foregroundColor: smackPurplePlaceHolder])
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(CreateAccountVC.handleTap))
        view.addGestureRecognizer(tap)
        
    }
    
    @objc func handleTap(){
        view.endEditing(true)
    }
    
}
