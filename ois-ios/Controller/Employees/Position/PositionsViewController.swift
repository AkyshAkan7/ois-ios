//
//  PositionsViewController.swift
//  ois-ios
//

import UIKit
import SwiftUI

class PositionsViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    var positions: [PositionModel]? = nil
    var positionManager = PositionManager()
    var selected: PositionModel? = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        positionManager.delegate = self
        positionManager.performRequest()
    }
    @IBAction func addButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "toCreatePositionVC", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "toCreatePositionVC") {
              let secondView = segue.destination as! CreatePoistionViewController
            secondView.delegate = self
           }
        if (segue.identifier == "toSpecificPosition") {
              let secondView = segue.destination as! SpecificPositionViewController
            secondView.position = selected
           }
    }
}

//MARK: - TableView Datasource and Delegate

extension PositionsViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return positions?.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! UITableViewCell
        cell.textLabel?.text = positions?[indexPath.row].label
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        selected = positions?[indexPath.row]
        performSegue(withIdentifier: "toSpecificPosition", sender: self)
    }
}

//MARK: - PositionStatus delegate

extension PositionsViewController: PositionManagerDelegate {
    func didSavePosition(_ positionManager: PositionManager, status: Bool) {
        
    }
    
    func didUpdateData(_ positionManager: PositionManager, models: [PositionModel]) {
        self.positions = models
        tableView.reloadData()
    }
    
    func didFailWithError(error: String) {
        print(error)
    }
}

extension PositionsViewController: createPositionDelegate {
    func didSaveData(succes: Bool) {
        positionManager.performRequest()
    }
}
