//
//  GroupFeedVC.swift
//  ChatApplication
//
//  Created by Georgi Malkhasyan on 11/19/18.
//  Copyright © 2018 Adamyan. All rights reserved.
//

import UIKit
import Firebase
class GroupFeedVC: UIViewController {

   
    @IBOutlet weak var groupTitle: UILabel!
    
    
    @IBOutlet weak var membersTextField: UILabel!
    
    @IBOutlet weak var sendMessage: UITextField!
    @IBOutlet weak var sendBtn: UIButton!
    
    var group: Group?
    func initData(forGroup groups: Group){
        self.group = groups
    }
    override func viewDidLoad() {
        super.viewDidLoad()

      sendBtn.bindToKeyboard()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
            groupTitle.text = group?.groupTitle
            getEmails(group: group!) { (returnemail) in
            self.membersTextField.text = returnemail.joined(separator: "; ")
        }
      
    }
    
    func getEmails(group: Group, handler: @escaping(_ emailArray: [String]) -> ()) {
        var emailArray = [String]()
        
        DataService.instance.REF_USERS.observeSingleEvent(of: .value) { (usersnap) in
            guard let snapUser = usersnap.children.allObjects as? [DataSnapshot] else { return }
            for user in snapUser {
                if group.members.contains(user.key){
                let email = user.childSnapshot(forPath: "email").value as! String
                    emailArray.append(email)
                }
            }
        }
    }
    
    
    @IBAction func sendBtnTapped(_ sender: Any) {
        
    }
    
    
    @IBAction func backTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
