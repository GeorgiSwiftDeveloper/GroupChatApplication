//
//  GroupCell.swift
//  ChatApplication
//
//  Created by Georgi Malkhasyan on 11/18/18.
//  Copyright © 2018 Adamyan. All rights reserved.
//

import UIKit

class GroupCell: UITableViewCell {

   
    @IBOutlet weak var groupTitle: UILabel!
    @IBOutlet weak var groupMembers: UILabel!
    @IBOutlet weak var groupDestination: UILabel!
    
    
    func categryCell(title: String, description: String, members: Int) {
        self.groupTitle.text = title
        self.groupDestination.text = description
        self.groupMembers.text = "\(members)"
    }
}
