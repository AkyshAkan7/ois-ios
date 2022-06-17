//
//  SpecificTreatmentViewController.swift
//  ois-ios
//
//  Created by Alikhan Nursapayev on 17.06.2022.
//

import UIKit

class SpecificTreatmentViewController: UIViewController {

    var index = 0
    var treatment: TreatmentModel? = nil
    var isNew: Bool = false
    
    @IBOutlet weak var startDatePick: UIDatePicker!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var endDatePick: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if !isNew {
            nameTextField.text = TreatData.treatments[index].description
        }
    }
    
    @IBAction func deletePressed(_ sender: Any) {
        if !isNew {
            TreatData.treatments.remove(at: index)
        navigationController?.popViewController(animated: true)
        }
    }
    @IBAction func savePressed(_ sender: Any) {
        if !isNew {
            TreatData.treatments[index] = TreatmentModel(uid: treatment?.uid ?? "", description: nameTextField.text ?? "", startDate: startDatePick.date.description, endDate: endDatePick.date.description)
        
        } else {
            TreatData.treatments.append(TreatmentModel(uid: treatment?.uid ?? "", description: nameTextField.text ?? "", startDate: startDatePick.date.description, endDate: endDatePick.date.description)) 
        }
        navigationController?.popViewController(animated: true)
    }
}
