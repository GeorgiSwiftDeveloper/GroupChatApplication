//
//  FeedVC.swift
//  ChatApplication
//
//  Created by Georgi Malkhasyan on 11/17/18.
//  Copyright © 2018 Adamyan. All rights reserved.
//

import UIKit
import Firebase
class FeedVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var feedTableView: UITableView!
       var messageArray : [Message] = [Message]()
    var keyArray = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()

        feedTableView.rowHeight = UITableView.automaticDimension
        feedTableView.delegate = self
        feedTableView.dataSource = self
        feedTableView.reloadData()
        
        retriveMessages()
    }
    
    func retriveMessages() {
        let messageDB = Database.database().reference().child("Message")
        messageDB.observe(.childAdded) { (snapshot) in
            let spanshotValue = snapshot.value as! Dictionary<String,String>
            let text = spanshotValue["content"]!
            let userSender = spanshotValue["senderId"]!
            
            let myMessage  = Message()
            myMessage.messagebody = text
            myMessage.sender = userSender
            
            self.messageArray.append(myMessage)
            
//            self.configureTableView()
            self.feedTableView.reloadData()
        }
    }
    
//    func configureTableView() {
//        feedTableView.rowHeight = UITableView.automaticDimension
//        feedTableView.estimatedRowHeight = 120.0
//    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messageArray.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as! FeedCell
        cell.configureGroupCell(messange: messageArray[indexPath.row])

        cell.userImage.image = UIImage(named: "defaultProfileImage")
        tableView.scrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: tableView.bounds.size.width - 10)

        if cell.userEmailLbl.text == Auth.auth().currentUser?.email {
            cell.messageLbl.textColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)

        }else {
            cell.messageLbl.textColor = #colorLiteral(red: 0.1764705926, green: 0.01176470611, blue: 0.5607843399, alpha: 1)
        }
        return cell
    }
    
   
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    //MARK: -- Delete  tableview cell data form  firebase
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            getAllKey()
            let when = DispatchTime.now() + 1
            DispatchQueue.main.asyncAfter(deadline: when) {
                Database.database().reference().child("Message").child(self.keyArray[indexPath.row]).removeValue()
                self.messageArray.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .automatic)
                self.keyArray = []
            }
        }
    }
      //MARK: -- Delete  tableview cell data form  firebase 
    func getAllKey(){
        Database.database().reference().child("Message").observeSingleEvent(of: .value) { (snapshot) in
          let user = snapshot.children.allObjects as? [DataSnapshot]
            for userSnap in user! {
                let key = userSnap.key
                self.keyArray.append(key)
            }
            
        }
    }

}
