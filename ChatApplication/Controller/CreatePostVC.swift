//
//  CreatePostVC.swift
//  ChatApplication
//
//  Created by Georgi Malkhasyan on 11/17/18.
//  Copyright © 2018 Adamyan. All rights reserved.
//

import UIKit
import Firebase
class CreatePostVC: UIViewController {
    
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userEmail: UILabel!
    @IBOutlet weak var messageTextView: UITextView!
    @IBOutlet weak var sendBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        messageTextView.delegate = self
        sendBtn.bindToKeyboard()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        userEmail.text = Auth.auth().currentUser?.email
    }
    
    //MARK: Create data and send  to Firebase and save
    @IBAction func sendBtnTapped(_ sender: Any) {
        if messageTextView.text != nil && messageTextView.text != "Say something here..." {
            sendBtn.isEnabled = false
            DataService.instance.uploadPost(withMessage: messageTextView.text, forUID: (Auth.auth().currentUser?.uid)!, withGroupKey: nil, sendComplete: { (isComplete) in
                if isComplete {
                    self.sendBtn.isEnabled = true
                    self.dismiss(animated: true, completion: nil)
                } else {
                    self.sendBtn.isEnabled = true
                    print("There was an error!")
                }
            })
        }
    }
    @IBAction func closeBtnTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
extension CreatePostVC: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        self.messageTextView.text = ""
    }
}
