//
//  TreatmentViewController.swift
//  ois-ios
//
//  Created by Alikhan Nursapayev on 17.06.2022.
//

import UIKit

class TreatmentViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var treatments: [String]? = nil
    var selectedIndex = 0
    var selectedTreatment: TreatmentModel? = nil
    var isNew: Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    @IBAction func addPressed(_ sender: Any) {
        isNew = true
        performSegue(withIdentifier: "toSpecificTreatment", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toSpecificTreatment" {
            let destinationVC = segue.destination as! SpecificTreatmentViewController
            destinationVC.index = selectedIndex
            destinationVC.treatment = selectedTreatment
            destinationVC.isNew = self.isNew
            
        }
    }

}

extension TreatmentViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TreatData.treatments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = TreatData.treatments[indexPath.row].description
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        selectedIndex = indexPath.row
        selectedTreatment = TreatData.treatments[indexPath.row]
        performSegue(withIdentifier: "toSpecificTreatment", sender: self)
    }
    
}
