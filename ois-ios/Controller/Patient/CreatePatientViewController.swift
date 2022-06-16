//
//  CreatePatientViewController.swift
//  ois-ios
//
//  Created by Alikhan Nursapayev on 14.06.2022.
//

import UIKit



protocol CreatePatientDelegate {
    func didCreatePatient(succes: Bool)
}

class CreatePatientViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    var manager = PatientManager()
    var delegate: CreatePatientDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        manager.delegate = self

        // Do any additional setup after loading the view.
    }
    
    @IBAction func savePressed(_ sender: Any) {
        manager.createPatientRequest(relativeFullName: nameTextField.text ?? "", relativePhoneNumber: phoneTextField.text ?? "", username: usernameTextField.text ?? "")
    }
    
}

extension CreatePatientViewController: PatientManagerDelegate {
    func didDelete(status: Bool) {
        
    }
    
    func didSaveData(status: Bool) {
        delegate?.didCreatePatient(succes: status)
        navigationController?.popViewController(animated: true)
    }
    
    func didUpdateData(_ positionManager: PatientManager, models: [PatientModel]) {
        
    }
    
    func didFailWithError(error: String) {
        print(error)
    }
    
    
}
