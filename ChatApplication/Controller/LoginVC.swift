//
//  FirstViewController.swift
//  ChatApplication
//
//  Created by Georgi Malkhasyan on 11/17/18.
//  Copyright © 2018 Adamyan. All rights reserved.
//

import UIKit
import Firebase
class LoginVC: UIViewController {

    
    @IBOutlet weak var emailTxt: UITextField!
    
    @IBOutlet weak var passwordTxt: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }


    @IBAction func signTappedBtn(_ sender: Any) {
        if emailTxt.text != nil && passwordTxt.text != nil  {
            AuthService.instance.registerUser(email: self.emailTxt.text!, password: self.passwordTxt.text!) { (success, error) in
                if error != nil  {
                    print(error?.localizedDescription as Any)
                }else {
                    AuthService.instance.loginUser(email: self.emailTxt.text!, password: self.passwordTxt.text!, loginCreationComplete: { (success, error) in
                        self.dismiss(animated: true, completion: nil)
                        print("Successfuly registered user")
                    })
                }
            }
            
        }
    }
    
    @IBAction func closeBtnTapped(_ sender: Any) {
         dismiss(animated: true, completion: nil)
    }
    
    
}

