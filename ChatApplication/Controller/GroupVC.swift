//
//  GroupVC.swift
//  ChatApplication
//
//  Created by Georgi Malkhasyan on 11/18/18.
//  Copyright © 2018 Adamyan. All rights reserved.
//

import UIKit
import Firebase
class GroupVC: UIViewController {
    

    @IBOutlet weak var groupTableView: UITableView!
    
    var groupsArray  = [Group]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        groupTableView.delegate = self
        groupTableView.dataSource = self
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        DataService.instance.REF_GROUPS.observe(.value) { (shapshot) in
            DataService.instance.gietAllGropups { (getGroupArray) in
                self.groupsArray = getGroupArray
                self.groupTableView.reloadData()
            }
        }
      
    }
    
    
    
    
}


extension GroupVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groupsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard   let cell = tableView.dequeueReusableCell(withIdentifier: "groupCell", for: indexPath) as? GroupCell else {return UITableViewCell()}
        let groupArray = groupsArray[indexPath.row]
        cell.categryCell(title: groupArray.groupTitle, description: groupArray.groupDesc, members: groupArray.memberCount)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let groupFeedVC = storyboard?.instantiateViewController(withIdentifier: "GroupFeedVC") as? GroupFeedVC else {return}
        groupFeedVC.initData(forGroup: groupsArray[indexPath.row])
        present(groupFeedVC, animated: true, completion: nil)
    }
}
