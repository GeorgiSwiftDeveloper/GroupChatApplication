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
  
    func configureCell(profileImage: UIImage, email: String, content: String) {
        self.userImage.image = profileImage
        self.userEmailLbl.text = email
        self.messageLbl.text = content
    }
}
