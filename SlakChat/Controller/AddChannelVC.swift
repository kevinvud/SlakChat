//
//  AddChannelVC.swift
//  SlakChat
//
//  Created by PoGo on 10/9/17.
//  Copyright © 2017 PoGo. All rights reserved.
//

import UIKit

class AddChannelVC: UIViewController {

    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var channelDescription: UITextField!
    @IBOutlet weak var nameTxt: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()

        
    }
    @IBAction func createChannel(_ sender: Any) {
        
        
        
    }
    
    @IBAction func closeModalPressed(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
        
    }
    
    func setupViews(){
        
        let closeTouch = UITapGestureRecognizer(target: self, action: #selector(AddChannelVC.closeTap(_:)))
        bgView.addGestureRecognizer(closeTouch)
        
       nameTxt.attributedPlaceholder = NSAttributedString(string: "Channel Name", attributes: [NSAttributedStringKey.foregroundColor: smackPurplePlaceHolder])
        channelDescription.attributedPlaceholder = NSAttributedString(string: "Description", attributes: [NSAttributedStringKey.foregroundColor: smackPurplePlaceHolder])
        
    }
    
    
    @objc func closeTap(_ recognizer: UITapGestureRecognizer){
        dismiss(animated: true, completion: nil)
    }
}
