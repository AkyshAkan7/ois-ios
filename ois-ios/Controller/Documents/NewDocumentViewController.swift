//
//  NewDocumentViewController.swift
//  ois-ios
//
//  Created by Alikhan Nursapayev on 17.06.2022.
//

import UIKit
import SwiftUI

class NewDocumentViewController: UIViewController {
   
    
    @IBOutlet weak var labelTextField: UITextField!
    
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var uidTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    var manager = DocumentsManager()
    var templates: [DocumentTemplateModel]? = nil
    var selectedTemplate = DocumentTemplateModel(uid: "678", label: "template", attachment: "none", documentType: DocumentTypeModel(id: 789, label: "jhjk", shortLabel: "jhjk", code: "234"), process: DocumentTypeModel(id: 2, label: "234", shortLabel: "d", code: "234"))
    override func viewDidLoad() {
        super.viewDidLoad()
        manager.delegate = self
        manager.getDocumentTemplate()
    }
    

    @IBAction func savePressed(_ sender: Any) {
        Doc.documentsList.append(DocumentsModel(uid: uidTextField.text ?? "", label: labelTextField.text ?? "", description: descriptionTextField.text ?? "", documentTemplate: selectedTemplate, creator: CreatorModel(username: "person", email: "none", iin: "656789", name: "Person", familyName: "Persons", mobilePhone: "98765678", patronymic: "76789", avatarUrl: "avatar.png")))
        navigationController?.popViewController(animated: true)
    }
    
}


extension NewDocumentViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = templates?[indexPath.row].label
        if let sel = templates?[indexPath.row].selected {
            if sel == true{
                cell.accessoryType = .checkmark
            } else {
                cell.accessoryType = .none
            }
        }
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return templates?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let sel = templates?[indexPath.row].selected {
            templates?[indexPath.row].selected = !sel
            print(sel)
        }
        tableView.deselectRow(at: indexPath, animated: true)
        tableView.reloadData()
        selectedTemplate = templates?[indexPath.row] ?? selectedTemplate
    }
}

extension NewDocumentViewController: DocumentsManagerDelegate {
    func didUpdateData(_ positionManager: DocumentsManager, models: [DocumentsModel]) {
        
    }
    
    func didGetTemplates(_ positionManager: DocumentsManager, models: [DocumentTemplateModel]) {
        self.templates = models
        print(models)
        tableView.reloadData()
    }
    
    func didFailWithError(error: String) {
        print(error)
    }
    
    func shouldUpdateUI(status: Bool) {
        
    }
}
