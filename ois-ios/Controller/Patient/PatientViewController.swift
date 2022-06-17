//
//  PatientViewController.swift
//  ois-ios
//
//  Created by Alikhan Nursapayev on 11.06.2022.
//

import UIKit

class PatientViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var patients: [PatientModel]? = nil
    var selected: PatientModel? = nil
    var manager = PatientManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        manager.delegate = self
        manager.performRequest()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        manager.performRequest()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toSpecificPatient" {
            let selectedVC = segue.destination as! SpecificPatientViewController
            selectedVC.pateint = selected
        }
    }
    

}


//MARK: - TableView Datasource and Delegate

extension PatientViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return patients?.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! UITableViewCell
        if let name = patients?[indexPath.row].relativeFullName {
            cell.textLabel?.text = name
        } else {
            cell.textLabel?.text = "N/A"
        }
        if let id = patients?[indexPath.row].id {
            cell.detailTextLabel?.text = "\(id)"
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        selected = patients?[indexPath.row]
        performSegue(withIdentifier: "toSpecificPatient", sender: self)
    }
}

extension PatientViewController: PatientManagerDelegate {
    func didDelete(status: Bool) {
        manager.performRequest()
    }
    
    func didSaveData(status: Bool) {
        manager.performRequest()
    }
    
    func didUpdateData(_ positionManager: PatientManager, models: [PatientModel]) {
        self.patients = models
        tableView.reloadData()
    }
    
    func didFailWithError(error: String) {
        print(error)
        
    }
    
    
}

extension PatientViewController: CreatePatientDelegate {
    func didCreatePatient(succes: Bool) {
        manager.performRequest()
    }
}
