//
//  SpecificPatientViewController.swift
//  ois-ios
//
//  Created by Alikhan Nursapayev on 14.06.2022.
//

import UIKit

class SpecificPatientViewController: UIViewController {

    @IBOutlet weak var name: UITextField!
    
    @IBOutlet weak var number: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var status: UITextField!
    var pateint: PatientModel? = nil
    var manager = PatientManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        print(pateint)
        manager.delegate = self
        if let nameText = pateint?.relativeFullName {
        name.text = nameText
        }
        if let numberText = pateint?.relativePhoneNumber {
            number.text = numberText
        }
        if let emailText = pateint?.user?.email {
            email.text = emailText
        } else {
            email.text = "N/A"
        }
        if let statusText = pateint?.user?.socialStatus?.label {
            status.text = statusText
        } else {
            status.text = "N/A"
        }
    }
    
    @IBAction func deletePressed(_ sender: Any) {
        if let patientId = pateint?.id {
            manager.deletePatient(id: patientId)
        }
        
    }
    
}

extension SpecificPatientViewController: PatientManagerDelegate {
    func didUpdateData(_ positionManager: PatientManager, models: [PatientModel]) {
        
    }
    
    func didSaveData(status: Bool) {
        
    }
    
    func didDelete(status: Bool) {
        navigationController?.popViewController(animated: true)    }
    
    func didFailWithError(error: String) {
        
    }
    
    
}
