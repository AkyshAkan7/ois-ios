//
//  CreateGroupViewController.swift
//  ois-ios
//
//

import UIKit

protocol CreateGroupDelegate {
    func didSaveData(succes: Bool)
}

class CreateGroupViewController: UIViewController {
    @IBOutlet weak var groupnameTextField: UITextField!
    
    @IBOutlet weak var labelTextField: UITextField!
    @IBOutlet weak var descriptionTextView: UITextField!
    var groupManager = GroupsManager()
    var delegate: CreateGroupDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        groupManager.delegate = self

    }
    @IBAction func savePressed(_ sender: Any) {
        
        groupManager.createGroup(groupname: groupnameTextField.text ?? "N/A", label: labelTextField.text ?? "N/A", description: descriptionTextView.text ?? "N/A")
    }
    
}

extension CreateGroupViewController: GroupsManagerDelegate {
    func didCreateGroup(succes: Bool) {
        delegate?.didSaveData(succes: true)
        navigationController?.popViewController(animated: true)
    }
    
    func didUpdateData(_ groupsManager: GroupsManager, models: [GroupsModel]) {
        
    }
    
    func didFailWithError(error: String) {
        
    }
    
    
}
