//
//  ChannelCell.swift
//  SlakChat
//
//  Created by PoGo on 10/9/17.
//  Copyright © 2017 PoGo. All rights reserved.
//

import UIKit

class ChannelCell: UITableViewCell {
    
    
    
    
    @IBOutlet weak var channelName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        if selected{
            self.layer.backgroundColor = UIColor(white: 1, alpha: 0.2).cgColor
        }else{
            self.layer.backgroundColor = UIColor.clear.cgColor
        }
    }
    
    func configureCell(channel: Channel){
        let title = channel.channelTiltle ?? ""
        channelName.text = "#\(title)"
        channelName.font = UIFont(name: "HelveticaNeue-Regular", size: 17)
        
        //check 
        for id in MessageService.instance.unreadChannels{
            if id == channel.id{
                channelName.font = UIFont(name: "HelveticaNeue-Bold", size: 22)
            }
        }
        
    }

}
