//
//  CategoryGroupVC.swift
//  ChatApplication
//
//  Created by Georgi Malkhasyan on 11/18/18.
//  Copyright © 2018 Adamyan. All rights reserved.
//

import UIKit
import Firebase
class CreateGroupsVC: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate {
    
    
    @IBOutlet weak var groupMemberLbl: UILabel!
    @IBOutlet weak var doneBtn: UIButton!
    @IBOutlet weak var titleTxt: UITextField!
    @IBOutlet weak var descriptionTxt: UITextField!
    @IBOutlet weak var emailSearchTxt: UITextField!
    var emailArray = [String]()
    var chosenUserArray = [String]()
    var keyArray = [String]()
    
    @IBOutlet weak var groupTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        groupTableView.delegate = self
        groupTableView.dataSource = self
       
        emailSearchTxt.delegate = self
        emailSearchTxt.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        doneBtn.isHidden = true
    }

    @objc func textFieldDidChange() {
        if emailSearchTxt.text == "" {
            emailArray = []
            groupTableView.reloadData()
        } else {
            DataService.instance.getEmail(forSearchQuery: emailSearchTxt.text!, handler: { (returnedEmailArray) in
                self.emailArray = returnedEmailArray
                self.groupTableView.reloadData()
            })
        }
    }
    
    

  //MARK: Create Group informaiton on Firebase Cloud and dissmiss controller
    @IBAction func doneBtnTapped(_ sender: Any) {
        if titleTxt.text != "" && descriptionTxt.text != "" {
            DataService.instance.getIds(forUserName: chosenUserArray) { (idArray) in
                var userId = idArray
                userId.append((Auth.auth().currentUser?.uid)!)
                
                DataService.instance.createGroup(withtTitle: self.titleTxt.text!, addDescription: self.descriptionTxt.text!, forUserID: userId, handler: { (groupCreated) in
                    if groupCreated {
                        self.dismiss(animated: true, completion: nil)
                    }else{
                        print("can not be created")
                    }
                })
            }
        }
    }

    
    //Dismiss Controller
    @IBAction func closeTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return emailArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "userCell") as? UserCell else { return UITableViewCell() }
        let profileImage = UIImage(named: "defaultProfileImage")
        
        if chosenUserArray.contains(emailArray[indexPath.row]) {
            cell.configureCell(porofileImage: profileImage!, email: emailArray[indexPath.row], isSelected: true)
        } else {
            cell.configureCell(porofileImage: profileImage!, email: emailArray[indexPath.row], isSelected: false)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? UserCell else { return }
        if !chosenUserArray.contains(cell.userEmail.text!) {
            chosenUserArray.append(cell.userEmail.text!)
            groupMemberLbl.text = chosenUserArray.joined(separator: ", ")
            doneBtn.isHidden = false
        } else {
            chosenUserArray = chosenUserArray.filter({ $0 != cell.userEmail.text! })
            if chosenUserArray.count >= 1 {
                groupMemberLbl.text = chosenUserArray.joined(separator: ", ")
            } else {
                groupMemberLbl.text = "add people to your group"
                doneBtn.isHidden = true
            }
        }
    }

    }
