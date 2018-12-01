//
//  FeedCell.swift
//  ChatApplication
//
//  Created by Georgi Malkhasyan on 11/17/18
//  Copyright © 2018 Adamyan. All rights reserved.
//

import UIKit

class FeedCell: UITableViewCell {

    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userEmailLbl: UILabel!
    @IBOutlet weak var messageLbl: UILabel!
  
    func configureGroupCell(messange: Message) {
        userImage.image = messange.image
        userEmailLbl.text = messange.sender
        messageLbl.text = messange.messagebody
    }
}
