//
//  ChannelVC.swift
//  SlakChat
//
//  Created by PoGo on 10/7/17.
//  Copyright © 2017 PoGo. All rights reserved.
//

import UIKit

class ChannelVC: UIViewController {

    
    @IBOutlet weak var loginBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.revealViewController().rearViewRevealWidth = self.view.frame.size.width - 60
        
        
    }
    
    @IBAction func loginBtnPressed(_ sender: Any){
        
        performSegue(withIdentifier: TO_LOGIN, sender: nil)
        
        
    }
}
