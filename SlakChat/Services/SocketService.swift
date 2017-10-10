//
//  SocketService.swift
//  SlakChat
//
//  Created by PoGo on 10/9/17.
//  Copyright © 2017 PoGo. All rights reserved.
//

import UIKit
import SocketIO

class SocketService: NSObject {
    
    static let instance = SocketService()
    
    override init() {
        super.init()
    }
    
    var socket : SocketIOClient = SocketIOClient(socketURL: URL(string: BASE_URL)!)
    
    func establishConnection(){
        socket.connect()
    }
    
    func closeConnection(){
        socket.disconnect()
    }
    
    func addChannel(channelName: String, channelDescription: String, completion: @escaping CompletionHandler){
        
        socket.emit("newChannel", channelName, channelDescription)
        completion(true)
        
    }
    
    func getChannel(completion: @escaping CompletionHandler){
        
        socket.on("channelCreated") { (dataArray, ack) in
            guard let channelName = dataArray[0] as? String else {return}
            guard let channelDesc = dataArray[1] as? String else {return}
            guard let channelID = dataArray[2] as? String else {return}
            
            let newChannel = Channel(channelTiltle: channelName, channelDescription: channelDesc, id: channelID)
            MessageService.instance.channels.append(newChannel)
            completion(true)
        }
        
    }
    
    func addMessage(messageBody: String, userId: String, channelId: String, completion: @escaping CompletionHandler){
        let user = UserDataService.instance
        
        socket.emit("newMessage", messageBody, userId, channelId, user.name, user.avatarName, user.avatarColor)
        completion(true)
        
        
    }
    
    func getChatMessage(completion: @escaping CompletionHandler){
        socket.on("messageCreated") { (dataArray, ack) in
            guard let msgBody = dataArray[0] as? String else{return}
            guard let channelId = dataArray[2] as? String else{return}
            guard let userName = dataArray[3] as? String else{return}
            guard let userAvatar = dataArray[4] as? String else{return}
            guard let userAvatarColor = dataArray[5] as? String else{return}
            guard let id = dataArray[6] as? String else{return}
            guard let timeStamp = dataArray[7] as? String else{return}
            
            if channelId == MessageService.instance.selectedChannel?.id && AuthService.instance.isLoggedIn{
                let newMessage = Message(message: msgBody, userName: userName, channelId: channelId, userAvatar: userAvatar, userAvatarColor: userAvatarColor, id: id, timeStamp: timeStamp)
                
                
                MessageService.instance.messages.append(newMessage)
                completion(true)
            } else{
                print("failed")
                completion(false)
            }
            
        }
    }
}