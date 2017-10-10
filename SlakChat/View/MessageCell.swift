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
        
        //2017-07-13T31:11:11Z
        
        guard var isoDate = message.timeStamp else {return}
        let end = isoDate.index(isoDate.endIndex, offsetBy: -5)
        isoDate = String(isoDate.prefix(upTo: end))

        let isoFormatter = ISO8601DateFormatter()
        let chatDate = isoFormatter.date(from: isoDate.appending("Z"))

        let newFormatter = DateFormatter()
        newFormatter.dateStyle = .long
        newFormatter.timeStyle = .short
        newFormatter.doesRelativeDateFormatting = true
        //newFormatter.dateFormat = "MMM d, h:mm a"
        
        if let finalDate = chatDate{
            let finalDate = newFormatter.string(from: finalDate)
            timeStamp.text = finalDate
            
        }
        
    }

}
