//
//  GroupFeedCell.swift
//  ChatApplication
//
//  Created by Georgi Malkhasyan on 11/19/18.
//  Copyright © 2018 Adamyan. All rights reserved
//

import UIKit

class GroupFeedCell: UITableViewCell {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var emaileLbl: UILabel!
    
    @IBOutlet weak var contentLbl: UILabel!

    
    func configureCell(image: UIImage,email: String, content: String) {
        profileImage.image = image
        emaileLbl.text = email
        contentLbl.text  = content
    }

}
