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
    @IBOutlet weak var membersTextField: UILabel!
    @IBOutlet weak var sendMessage: UITextField!
    @IBOutlet weak var sendBtn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sendBtn.bindToKeyboard()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    
    
    
    
    @IBAction func sendBtnTapped(_ sender: Any) {
        
    }
    
    
    @IBAction func backTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
