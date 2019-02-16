//
//  MessageModel.swift
//  ChatApplication
//
//  Created by Georgi Malkhasyan on 11/17/18
//  Copyright © 2018 Adamyan. All rights reserved.
//

import Foundation
import UIKit
class Message {
    private var _content: String
    private var _senderId: String
    
    var content: String {
        return _content
    }
    
    var senderId: String {
        return _senderId
    }
    
    init(content: String, senderId: String) {
        self._content = content
        self._senderId = senderId
    }
}
