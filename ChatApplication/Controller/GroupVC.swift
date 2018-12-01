//
//  GroupVC.swift
//  ChatApplication
//
//  Created by Georgi Malkhasyan on 11/18/18.
//  Copyright © 2018 Adamyan. All rights reserved.
//

import UIKit
import Firebase
class GroupVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    

    @IBOutlet weak var groupTableView: UITableView!
    
    var groupArray = [Group]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        groupTableView.delegate = self
        groupTableView.dataSource = self
        
      
    
}
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        //MARK:Pass group array to the tableview
        Database.database().reference(withPath: "GROUP").observe(.value) { (snapshot) in
            self.getAllGroups(handler: { (returnGroups) in
                self.groupArray = returnGroups
                self.groupTableView.reloadData()
            })
        }
    }
    
//MARK: Pull all groups from Firebase, create array of group
    func getAllGroups(handler: @escaping (_ gropsArray: [Group]) -> ()) {
        var groupsArray = [Group]()
        Database.database().reference(withPath: "GROUP").observeSingleEvent(of: .value) { (groupSnapshot) in
            guard let groupSnapshot = groupSnapshot.children.allObjects as? [DataSnapshot] else {return}
            for group in groupSnapshot {
                let memberArray = group.childSnapshot(forPath: "useriD").value as! [String]
                if memberArray.contains((Auth.auth().currentUser?.uid)!){
                    let title = group.childSnapshot(forPath: "title").value as! String
                    let description = group.childSnapshot(forPath: "description").value as! String
                    
                    let group = Group(title: title, description: description, key: group.key, members: memberArray, memberCount: memberArray.count)
                    groupsArray.append(group)
                }
            }
            handler(groupsArray)
        }
    }


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groupArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      guard let cell = tableView.dequeueReusableCell(withIdentifier: "groupCell", for: indexPath) as? GroupCell else { return  UITableViewCell()}
        let group = groupArray[indexPath.row]
        cell.categryCell(title: group.groupTitle , description: group.groupDesc, members: group.memberCount)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let groupFeddVC = storyboard.instantiateViewController(withIdentifier: "GroupFeedVC") as? GroupFeedVC else { return }
        groupFeddVC.initData(forGroup: groupArray[indexPath.row])
        present(groupFeddVC, animated: true, completion: nil)
    }
}

