//
//  MeVC.swift
//  ChatApplication
//
//  Created by Georgi Malkhasyan on 11/17/18.
//  Copyright © 2018 Adamyan. All rights reserved.
//

import UIKit
import Firebase
class MeVC: UIViewController {

   
    @IBOutlet weak var userEmail: UILabel!
    @IBOutlet weak var userImage: UIImageView!
     override func viewDidLoad() {
        super.viewDidLoad()

       userEmail.text = Auth.auth().currentUser?.email
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       userEmail.text = Auth.auth().currentUser?.email
    }
    
//MARK: SignOut function from Chat App
    @IBAction func logOutTapped(_ sender: Any) {
        do{
            try Auth.auth().signOut()
            let authVC = self.storyboard?.instantiateViewController(withIdentifier: "AuthVC") as? AuthVC
            self.present(authVC!, animated: true, completion: nil)
        }catch{
            print("Some eror cat log out")
        }
    }
    

}
