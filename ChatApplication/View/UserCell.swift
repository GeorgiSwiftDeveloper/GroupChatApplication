//
//  UserCell.swift
//  ChatApplication
//
//  Created by Georgi Malkhasyan on 11/18/18.
//  Copyright © 2018 Adamyan. All rights reserved.
//

import UIKit

class UserCell: UITableViewCell {

   
    @IBOutlet weak var userImage: UIImageView!
    
    @IBOutlet weak var usersCheckMark: UIImageView!
    @IBOutlet weak var userEmail: UILabel!
    
    
    
    var showing =  false
    
    func configureCell(porofileImage image: UIImage, email: String, isSelected: Bool) {
        self.userImage.image = image
        self.userEmail.text = email
        if isSelected{
            self.usersCheckMark.isHidden = false
        }else {
            self.usersCheckMark.isHidden = true
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        if selected {
            if showing == false {
                usersCheckMark.isHidden = false
                showing = true
            }else {
                usersCheckMark.isHidden = true
                showing = false
            }
        }
        
    }
}
