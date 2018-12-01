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

        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        userEmail.text = Auth.auth().currentUser?.email
    }
    
    //MARK: Send data to Firebase and save
    @IBAction func sendBtnTapped(_ sender: Any) {
        if messageTextView.text != "" && messageTextView.text != "Say something here..." {
        self.sendBtn.isEnabled = false
        print("Enter corect text!")
        let messageDB = Database.database().reference().child("Message")
        let messageDictionary = ["senderId": Auth.auth().currentUser?.email, "content": messageTextView.text!]
        messageDB.childByAutoId().setValue(messageDictionary){
            (error,reference) in
            if error != nil {
                print(error!)
            }else {
                print("message Save successfully!")
                self.messageTextView.text = ""
                self.sendBtn.isEnabled = true
            }
            
        }
        
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
