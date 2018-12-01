//
//  AuthServiceVC.swift
//  ChatApplication
//
//  Created by Georgi Malkhasyan on 11/17/18.
//  Copyright © 2018 Adamyan. All rights reserved
//

import Foundation
import Firebase
class AuthService: UIViewController {
    static let instance = AuthService()
    
    func registerUser(email: String, password: String, userCreationComplete: @escaping (_ status : Bool, _ error: Error?) -> ()) {
        
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            if error != nil {
                userCreationComplete(false, error)
                return
            }
            let userData = ["provider": user?.user.providerID, "email": user?.user.email]
            DataService.instance.createDBUser(uid: (user?.user.uid)!, userData: userData)
            
            userCreationComplete(true, nil)
        }
    }
    
    
    
    func loginUser(email: String, password: String, loginCreationComplete: @escaping (_ status : Bool, _ error: Error?) -> ()) {
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if error != nil {
                loginCreationComplete(false, error)
                return
            }
            loginCreationComplete(true, nil)
        }
    }
}
