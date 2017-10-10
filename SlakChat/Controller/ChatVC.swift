//
//  ChatVC.swift
//  SlakChat
//
//  Created by PoGo on 10/7/17.
//  Copyright © 2017 PoGo. All rights reserved.
//

import UIKit

class ChatVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var messageTextBox: UITextField!
    
    @IBOutlet weak var channelNameLbl: UILabel!
    
    @IBOutlet weak var menuBtn: UIButton!
    
    @IBOutlet weak var tableView: UITableView!
    
    // For send button
    var isTyping = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sendButton.isHidden = true
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 80
        tableView.rowHeight = UITableViewAutomaticDimension
        
        view.bindToKeyboard()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(ChatVC.handleTap))
        view.addGestureRecognizer(tap)
        
        menuBtn.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
        
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(ChatVC.userDataDidChange(_:)), name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(ChatVC.channelSelected(_:)), name: NOTIF_CHANNEL_SELECTED, object: nil)
        
        SocketService.instance.getChatMessage(completion: { (success) in
            if success{
                self.tableView.reloadData()
                
                if MessageService.instance.messages.count > 0{
                    
                    let index = IndexPath(row: MessageService.instance.messages.count - 1, section: 0)
                    self.tableView.scrollToRow(at: index, at: .bottom, animated: false)
                    
                }
            }
        })
        
        if AuthService.instance.isLoggedIn{
            AuthService.instance.findUserByEmail(completion: { (success) in
                if success{
                    NotificationCenter.default.post(name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
                }
            })
        }
        

    }
    @objc func channelSelected(_ notif: Notification){
    
        updateWithChannel()
    
    
    }
    
    func updateWithChannel(){
        let channelName = MessageService.instance.selectedChannel?.channelTiltle ?? ""
        channelNameLbl.text = "#\(channelName)"
        getMessages()
    }
    
    @objc func userDataDidChange(_ notif: Notification){
        if AuthService.instance.isLoggedIn{
            onLoginGetMessages()
        }else{
            channelNameLbl.text = "Please Log In"
            tableView.reloadData()
        }
    }
    
    func onLoginGetMessages(){
        MessageService.instance.findAllChannel { (success) in
            if success{
                if MessageService.instance.channels.count > 0{
                    MessageService.instance.selectedChannel = MessageService.instance.channels[0]
                    self.updateWithChannel()
                } else{
                    self.channelNameLbl.text = "No channels yet!"
                }
            }
        }
    }
    @objc func handleTap(){
        view.endEditing(true)
    }
    
    func getMessages(){
        guard let channelId = MessageService.instance.selectedChannel?.id else{return}
        MessageService.instance.findAllMessageForChannel(channelId: channelId) { (success) in
            if success{
                self.tableView.reloadData()
            }
        }
    }
    
    @IBAction func messageBoxEditing(_ sender: Any) {
        if messageTextBox.text == ""{
            isTyping = false
            sendButton.isHidden = true
        }else{
            if isTyping == false{
                sendButton.isHidden = false
            }
            isTyping = true
        }
        
        
    }
    @IBAction func sendMessagePressed(_ sender: Any) {
        
        if AuthService.instance.isLoggedIn{
            guard let channelId = MessageService.instance.selectedChannel?.id else{return}
            guard let message = messageTextBox.text else {return}
            
            SocketService.instance.addMessage(messageBody: message, userId: UserDataService.instance.id, channelId: channelId, completion: { (success) in
                if success{
                    self.messageTextBox.text = ""
                    self.messageTextBox.resignFirstResponder()
                }
            })
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "messageCell", for: indexPath) as? MessageCell{
            let message = MessageService.instance.messages[indexPath.row]
            cell.configureCell(message: message)
            return cell
        } else{
            return UITableViewCell()
        }

    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MessageService.instance.messages.count
    }

}
