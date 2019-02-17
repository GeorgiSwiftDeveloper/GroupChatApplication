//
//  GroupFeedVC.swift
//  ChatApplication
//
//  Created by Georgi Malkhasyan on 11/19/18
//  Copyright © 2018 Adamyan. All rights reserved.
//

import UIKit
import Firebase
class GroupFeedVC: UIViewController {
    
    @IBOutlet weak var groupTitle: UILabel!

    @IBOutlet weak var membersLbl: UILabel!
    @IBOutlet weak var sendMessage: UITextField!
    @IBOutlet weak var sendBtn: UIButton!
    
    var group: Group?
    @IBOutlet weak var groupFeedTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        sendBtn.bindToKeyboard()
    }
    

    
    func initData(forGroup group: Group) {
        self.group = group
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        groupTitle.text = group?.groupTitle
        DataService.instance.getEmailsFor(group: group!) { (returnEmails) in
            self.membersLbl.text =  returnEmails.joined(separator: ", ")
        }
        
    }
    
    
    
    
    
    @IBAction func sendBtnTapped(_ sender: Any) {
        
    }
    
    
    @IBAction func backTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
