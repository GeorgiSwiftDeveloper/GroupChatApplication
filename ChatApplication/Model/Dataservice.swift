//
//  Dataservice.swift
//  ChatApplication
//
//  Created by Georgi Malkhasyan on 11/18/18.
//  Copyright © 2018 Adamyan. All rights reserved
//

import Foundation
import Firebase

let DB_BASE = Database.database().reference()

class DataService {
    static let instance = DataService()
    
    private var _REF_BASE = DB_BASE
    private var _REF_USERS = DB_BASE.child("users")
    private var _REF_GROUPS = DB_BASE.child("groups")
    private var _REF_FEED = DB_BASE.child("feed")
    
    var REF_BASE: DatabaseReference {
        return _REF_BASE
    }
    
    var REF_USERS: DatabaseReference {
        return _REF_USERS
    }
    
    var REF_GROUPS: DatabaseReference {
        return _REF_GROUPS
    }
    
    var REF_FEED: DatabaseReference {
        return _REF_FEED
    }
    
    func createDBUser(uid: String, userData: Dictionary<String, Any>) {
        REF_USERS.child(uid).updateChildValues(userData)
    }
    
    func getUsername(forUID uid: String, handler: @escaping (_ username: String) -> ()) {
        REF_USERS.observeSingleEvent(of: .value) { (userSnapshot) in
            guard let userSnapshot = userSnapshot.children.allObjects as? [DataSnapshot] else { return }
            for user in userSnapshot {
                if user.key == uid {
                    handler(user.childSnapshot(forPath: "email").value as! String)
                }
            }
        }
    }
    
    func uploadPost(withMessage message: String, forUID uid: String, withGroupKey groupKey: String?, sendComplete: @escaping (_ status: Bool) -> ()) {
        if groupKey != nil {
            // send to groups ref
        } else {
            REF_FEED.childByAutoId().updateChildValues(["content": message, "senderId": uid])
            sendComplete(true)
        }
    }
    
    //MAKR: Return all information from Firebase to FeedVC
    func getAllFeedMessages(handler: @escaping (_ messages: [Message]) -> ()) {
        var messageArray = [Message]()
        REF_FEED.observeSingleEvent(of: .value) { (feedMessageSnapshot) in
            guard let feedMessageSnapshot = feedMessageSnapshot.children.allObjects as? [DataSnapshot] else { return }
            for message in feedMessageSnapshot {
                let content = message.childSnapshot(forPath: "content").value as! String
                let senderId = message.childSnapshot(forPath: "senderId").value as! String
                let message = Message(content: content, senderId: senderId)
                messageArray.append(message)
            }
            
            handler(messageArray)
        }
    }
    
    func getEmail(forSearchQuery query: String, handler: @escaping (_ emailArray: [String]) -> ()) {
        var emailArray = [String]()
        REF_USERS.observe(.value) { (userSnapshot) in
            guard let userSnapshot = userSnapshot.children.allObjects as? [DataSnapshot] else { return }
            for user in userSnapshot {
                let email = user.childSnapshot(forPath: "email").value as! String
                
                if email.contains(query) == true && email != Auth.auth().currentUser?.email {
                    emailArray.append(email)
                }
            }
            handler(emailArray)
        }
    }
    
    
    func getIds(forUserName usernames: [String], handler: @escaping (_ uidArray: [String]) -> ()) {
        REF_USERS.observeSingleEvent(of: .value) { (userSnapshot) in
            var idArray = [String]()
            guard let userSnap = userSnapshot.children.allObjects as? [DataSnapshot] else { return }
            for user in userSnap {
                  let email = user.childSnapshot(forPath: "email").value as! String
                if usernames.contains(email) {
                    idArray.append(user.key)
                }
            }
            handler(idArray)
        }
    }
    
    
    func getEmailsFor(group: Group, handler: @escaping(_ emailArray: [String]) -> ()) {
        var emailsArray = [String]()
        REF_USERS.observeSingleEvent(of: .value) { (userSnap) in
            guard let userSnap = userSnap.children.allObjects as? [DataSnapshot] else {return}
            for user in userSnap {
                if  group.members.contains(user.key) {
                    let email = user.childSnapshot(forPath: "email").value as! String
                    emailsArray.append(email)
                }
            }
            handler(emailsArray)
        }
    }
    
    func createGroup(withtTitle title: String, addDescription description: String, forUserID ids:[String], handler: @escaping(_ groupCreated: Bool) -> ()) {
        
        REF_GROUPS.childByAutoId().updateChildValues(["title": title,"description": description,"members": ids])
        handler(true)
    }
    
    
    func gietAllGropups(handler: @escaping (_ groupsArray: [Group]) -> ()) {
        var groupsArray = [Group]()
        REF_GROUPS.observeSingleEvent(of: .value) { (groupSnap) in
            guard  let groupsnap = groupSnap.children.allObjects as? [DataSnapshot] else {return}
            for group in groupsnap {
                let memberArray = group.childSnapshot(forPath: "members").value as? [String]
                if (memberArray?.contains((Auth.auth().currentUser?.uid)!))! {
                    let title = group.childSnapshot(forPath: "title").value as? String
                    let description = group.childSnapshot(forPath: "description").value as? String
                    let group = Group(title: title!, description: description!, key: group.key, members: memberArray!, memberCount: (memberArray?.count)!)
                    groupsArray.append(group)
                }
            }
            handler(groupsArray)
        }
    }
}
