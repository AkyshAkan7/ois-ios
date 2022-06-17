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
    var isNew: Bool = true
    var groupManager = GroupsManager()
    var delegate: CreateGroupDelegate?
    
    var group: GroupsModel? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        groupManager.delegate = self
        
        if !isNew {
            groupnameTextField.text = group?.groupname
            labelTextField.text = group?.label
            descriptionTextView.text = group?.description
        }

    }
    @IBAction func savePressed(_ sender: Any) {
        
        if isNew {
        groupManager.createGroup(groupname: groupnameTextField.text ?? "N/A", label: labelTextField.text ?? "N/A", description: descriptionTextView.text ?? "N/A")
        } else {
            groupManager.changeGroup(groupname: groupnameTextField.text ?? "N/A", label: labelTextField.text ?? "N/A", description: descriptionTextView.text ?? "N/A")
        }
    }
    @IBAction func deletePressed(_ sender: Any) {
        groupManager.deleteGroup(groupname: groupnameTextField.text ?? "N/A", label: labelTextField.text ?? "N/A", description: descriptionTextView.text ?? "N/A")
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
