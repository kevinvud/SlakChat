//
//  MessageCell.swift
//  SlakChat
//
//  Created by PoGo on 10/9/17.
//  Copyright © 2017 PoGo. All rights reserved.
//

import UIKit

class MessageCell: UITableViewCell {

    @IBOutlet weak var userImage: CircleImage!
    
    @IBOutlet weak var userNameLabel: UILabel!
    
    @IBOutlet weak var timeStamp: UILabel!
    
    @IBOutlet weak var messageBodyLabel: UILabel!
    
    
    override func awakeFromNib() {

        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCell(message: Message){
        
        messageBodyLabel.text = message.message
        userNameLabel.text = message.userName
        userImage.image = UIImage(named: message.userAvatar)
        userImage.backgroundColor = UserDataService.instance.returnUIColor(components: message.userAvatarColor)
        
    }

}
