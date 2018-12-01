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
    
    
    
    private var _REF_USERS = DB_BASE.child("users")
    private var _REF_GROUPS = DB_BASE.child("GROUP")
    private var _REF_FEED = DB_BASE.child("feed")
    
    var REF_USERS: DatabaseReference {
        return _REF_USERS
    }
    var REF_GROUPS: DatabaseReference {
        return _REF_GROUPS
    }
    var REF_FEED: DatabaseReference {
        return _REF_FEED
    }
    
    
//    func uploadPost(withMessage message: String, forUID uid: String, withGroupKey groupKey: String?, sendComplete: @escaping (_ status: Bool) -> ()) {
//        if groupKey != nil {
//            REF_GROUPS.child(groupKey!).child("messages").childByAutoId().updateChildValues(["content": message, "senderId": uid])
//            sendComplete(true)
//        } else {
//            REF_FEED.childByAutoId().updateChildValues(["content": message, "senderId": uid])
//            sendComplete(true)
//        }
//    }
    
//    func getAllFeedMessages(handler: @escaping (_ messages: [Message]) -> ()) {
//        var messageArray = [Message]()
//        REF_FEED.observeSingleEvent(of: .value) { (feedMessageSnapshot) in
//            guard let feedMessageSnapshot = feedMessageSnapshot.children.allObjects as? [DataSnapshot] else { return }
//
//            for message in feedMessageSnapshot {
//                let content = message.childSnapshot(forPath: "content").value as! String
//                let senderId = message.childSnapshot(forPath: "senderId").value as! String
//                let message = Message(content: content, senderId: senderId)
//                messageArray.append(message)
//            }
//
//            handler(messageArray)
//        }
//    }
    

    func createDBUser(uid: String, userData: Dictionary<String, Any>) {
        REF_USERS.child(uid).updateChildValues(userData)
    }
    
    
}
