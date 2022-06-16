//
//  OrgsViewController.swift
//  ois-ios
//
//

import UIKit

class OrgsViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    var organizations: [OrgsModel]? = nil
    var orgsManager = OrgsManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        orgsManager.delegate = self
        orgsManager.performRequest()

    }
}

extension OrgsViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return organizations?.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! UITableViewCell
        cell.textLabel?.text = organizations?[indexPath.row].label
        return cell
    }
    
    
}

extension OrgsViewController: OrgsManagerDelegate {
    func didUpdateData(_ groupsManager: OrgsManager, models: [OrgsModel]) {
        self.organizations = models
        tableView.reloadData()
    }
    
    func didFailWithError(error: String) {
        print(error)
    }
    
    
    
}
