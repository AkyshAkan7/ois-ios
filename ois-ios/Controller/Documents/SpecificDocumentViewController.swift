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
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = document?.label
        created.text = document?.creator.username
        documentType.text = document?.documentTemplate?.documentType.label
        descriptionArea.text = document?.description
        documentsManager.delegate = self
        print(document)
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
                    self.documentsManager.deleteDocumentRequest(id: document.uid ?? "")
                    
                }
            }))
            self.present(alert, animated: true, completion: nil)

        }
    }
    @IBAction func savePressed(_ sender: Any) {
        
    }
}

extension SpecificDocumentViewController: DocumentsManagerDelegate {
    func didUpdateData(_ positionManager: DocumentsManager, models: [DocumentsModel]) {
        
    }
    
    func didFailWithError(error: String) {
        print(error)
    }
    
    func shouldUpdateUI(status: Bool) {
        
        navigationController?.popViewController(animated: true)
    }
}
