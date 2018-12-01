//
//  CategoryGroupVC.swift
//  ChatApplication
//
//  Created by Georgi Malkhasyan on 11/18/18.
//  Copyright © 2018 Adamyan. All rights reserved.
//

import UIKit
import Firebase
class CategoryGroupVC: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate {

    

    @IBOutlet weak var descLbl: UILabel!
    @IBOutlet weak var doneBtn: UIButton!
    @IBOutlet weak var titleTxt: UITextField!
    @IBOutlet weak var descriptionTxt: UITextField!
    @IBOutlet weak var emailSearchTxt: UITextField!
    var emailArray = [String]()
    var choosenArray = [String]()
    var keyArray = [String]()
    
    @IBOutlet weak var groupTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        groupTableView.delegate = self
        groupTableView.dataSource = self
       
        emailSearchTxt.delegate = self
        emailSearchTxt.addTarget(self, action: #selector(textFiedsearch), for: .editingChanged)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        doneBtn.isHidden = true
    }
    
       //MARK: TextFild func show user email on tableView
    @objc func textFiedsearch() {
        if emailSearchTxt.text == "" {
            emailArray = []
            groupTableView.reloadData()
        }else {
            getEmail(forSerchQuery: emailSearchTxt.text!) { (returnArray) in
                self.emailArray = returnArray
                self.groupTableView.reloadData()
                
            }
            
        }
    }
    
        //MARK: get all email from Firebase
    func getEmail(forSerchQuery query: String, handler: @escaping (_ emailArray: [String]) -> ()) {
        var emailArray = [String]()
            DataService.instance.REF_USERS.observe(.value) { (userSnapshot) in
            guard let userSnapshot = userSnapshot.children.allObjects as? [DataSnapshot] else {return}
            
            for user in userSnapshot {
                let email = user.childSnapshot(forPath: "email").value as! String
                if email.contains(query) == true && email != Auth.auth().currentUser?.email {
                    emailArray.append(email)
                }
            }
            handler(emailArray)
        }
    }
    
     //MARK: Get Firebase Sender Ids and pass it to the function
    func getIds(forUsername username: [String], handler: @escaping(_ uidArray: [String])-> ()) {
        var idArray = [String]()
        DataService.instance.REF_USERS.observeSingleEvent(of: .value) { (snap) in
          guard   let usersnap = snap.children.allObjects as? [DataSnapshot] else {return}
            for user in usersnap {
                let email = user.childSnapshot(forPath: "email").value as! String
                if username.contains(email){
                    idArray.append(user.key)
                }
            }
            handler(idArray)
        }
        
    }
  //MARK: Create Group informaiton on Firebase Cloud and dissmiss controller
    @IBAction func doneBtnTapped(_ sender: Any) {
        if titleTxt.text != "" && descriptionTxt.text != "" {
            getIds(forUsername: choosenArray) { (idsArray) in
                var userIds = idsArray
                userIds.append((Auth.auth().currentUser?.uid)!)
                self.createGroup(withTitle: self.titleTxt.text!, withDescrip: self.descriptionTxt.text!, forUserId: userIds, handler: { (group) in
                    if group {
                        self.dismiss(animated: true, completion: nil)
                    }else {
                        print("could not created")
                    }
                })
            }
        }
    }
    
        //MARK: Create a new reference on Firebase Group
    
    func createGroup(withTitle title: String, withDescrip description: String, forUserId uId: [String], handler: @escaping(_ groupCreated: Bool )  -> ()) {
        Database.database().reference().child("GROUP").childByAutoId().updateChildValues(["title": title, "description": description, "useriD": uId])
        handler(true)
    }
    
    //Dismiss Controller
    @IBAction func closeTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return emailArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard   let cell = tableView.dequeueReusableCell(withIdentifier: "myuserCell", for: indexPath) as? UserCell else {return UITableViewCell()
        }
        let profileImage = UIImage(named: "defaultProfileImage")
        cell.configureCell(porofileImage: profileImage!, email: self.emailArray[indexPath.row], isSelected: true)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard  let cell = tableView.cellForRow(at: indexPath) as? UserCell else { return }
        if !choosenArray.contains(cell.userEmail.text!) {
            choosenArray.append(cell.userEmail.text!)
            descLbl.text = choosenArray.joined(separator: " , ")
            doneBtn.isHidden = false
        }else {
            choosenArray = choosenArray.filter({$0 != cell.userEmail.text!})
            if choosenArray.count >= 1 {
                descLbl.text = choosenArray.joined(separator: " , ")
            }else {
                descLbl.text = "add people"
                doneBtn.isHidden = true
            }
        }
    }
    
    
   
    
}
