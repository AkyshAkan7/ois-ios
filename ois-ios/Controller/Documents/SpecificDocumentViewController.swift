//
//  SpecificDocumentViewController.swift
//  ois-ios
//
//

import UIKit

class SpecificDocumentViewController: UIViewController {
    
    var document: DocumentsModel? = nil
    
    @IBOutlet weak var documentType: UITextField!
    @IBOutlet weak var created: UITextField!
    @IBOutlet weak var descriptionArea: UITextView!
    var documentsManager = DocumentsManager()
    var index = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = document?.label
        created.text = document?.creator.username
        documentType.text = document?.documentTemplate?.documentType.label
        descriptionArea.text = document?.description
        documentsManager.delegate = self
    }
    @IBAction func deletePressed(_ sender: Any) {
        if let document = document {
            let alert = UIAlertController(title: "Внимание", message: "Точно удалить?", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Нет", style: .default, handler: { action in
                switch action.style{
                    case .default:
                    print("def")
                    case .cancel:
                    print("cancel")
                    
                    case .destructive:
                    print("destructive")
                    
                }
            }))
            alert.addAction(UIAlertAction(title: "Да", style: .destructive, handler: { action in
                switch action.style{
                    case .default:
                    print("def")
                    case .cancel:
                    print("cancel")
                    
                    case .destructive:
                    print("destructive")
                    self.documentsManager.deleteDocumentRequest(index: self.index)
                    
                }
            }))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    @IBAction func savePressed(_ sender: Any) {
        Doc.documentsList[index] = DocumentsModel(uid: "5678", label: "Документ", description: descriptionArea.text, documentTemplate: DocumentTemplateModel(uid: "678", label: "template", attachment: "none", documentType: DocumentTypeModel(id: 789, label: documentType.text ?? "", shortLabel: "jhjk", code: "234"), process: DocumentTypeModel(id: 2, label: "234", shortLabel: "d", code: "234")), creator: CreatorModel(username: "person", email: "none", iin: "656789", name: created.text ?? "", familyName: "Persons", mobilePhone: "98765678", patronymic: "76789", avatarUrl: "avatar.png"))
        navigationController?.popViewController(animated: true)
    }
}

extension SpecificDocumentViewController: DocumentsManagerDelegate {
    func didGetTemplates(_ positionManager: DocumentsManager, models: [DocumentTemplateModel]) {
        
    }
    
    func didUpdateData(_ positionManager: DocumentsManager, models: [DocumentsModel]) {
        
    }
    
    func didFailWithError(error: String) {
        print(error)
    }
    
    func shouldUpdateUI(status: Bool) {
        
        navigationController?.popViewController(animated: true)
    }
}
