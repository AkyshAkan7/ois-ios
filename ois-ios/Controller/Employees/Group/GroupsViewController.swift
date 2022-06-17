//
//  GroupsViewController.swift
//  ois-ios
//
//  Created by Alikhan Nursapayev on 09.06.2022.
//

import UIKit
import SwiftUI
import SystemConfiguration

class GroupsViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    var groups: [GroupsModel]? = nil
    var groupsManager = GroupsManager()
    
    var isNew = false
    var selectedGroup: GroupsModel? = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        groupsManager.delegate = self
        groupsManager.performRequest(with: "", email: "", password: "")
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        groupsManager.performRequest(with: "", email: "", password: "")
        
    }

    @IBAction func addPressed(_ sender: Any) {
        performSegue(withIdentifier: "toCreateGroup", sender: self)
        isNew = true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toCreateGroup" {
          let secondView = segue.destination as! CreateGroupViewController
          secondView.delegate = self
        secondView.isNew = self.isNew
          secondView.group = selectedGroup
        }
    }
}


extension GroupsViewController: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groups?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! UITableViewCell
        cell.textLabel?.text = groups?[indexPath.row].label
        cell.detailTextLabel?.text = groups?[indexPath.row].description
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedGroup = groups?[indexPath.row]
        isNew = false
        performSegue(withIdentifier: "toCreateGroup", sender: self)
    }
}

extension GroupsViewController: GroupsManagerDelegate {
    func didCreateGroup(succes: Bool) {
        
    }
    
    
    func didUpdateData(_ groupsManager: GroupsManager, models: [GroupsModel]) {
        self.groups = models
        tableView.reloadData()
    }
    
    func didFailWithError(error: String) {
        print(error)
    }
    
    
}


extension GroupsViewController: CreateGroupDelegate {
    func didSaveData(succes: Bool) {
        groupsManager.performRequest(with: "", email: "", password: "")
    }
}
