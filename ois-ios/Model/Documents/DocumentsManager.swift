//
//  DocumentsManager.swift
//  ois-ios
//
//  Created by Alikhan Nursapayev on 11.06.2022.
//

import Foundation
import Alamofire

protocol DocumentsManagerDelegate {
    func didUpdateData(_ positionManager: DocumentsManager, models: [DocumentsModel])
    func didGetTemplates(_ positionManager: DocumentsManager, models: [DocumentTemplateModel])
    func didFailWithError(error: String)
    func shouldUpdateUI(status: Bool)
}

struct DocumentsManager {
    
    let defaults = UserDefaults.standard
    var delegate: DocumentsManagerDelegate?
    
    func performRequest() {
        let token = defaults.string(forKey: "token")!
        let headers: HTTPHeaders = [
            "Authorization": "Bearer " + token
        ]
        
        let request = AF.request("http://localhost:8080/api/v1/dicts/documents", method: .get, headers: headers).response {
            (responseData) in
            guard let data = responseData.data else {return}
            do {
                if let code = responseData.response?.statusCode {
                    let decoder = JSONDecoder()
                    let documents = try decoder.decode([DocumentsData].self, from: data)
                    
                    if code == 200 {
                        
                        var documentsArray: [DocumentsModel] = []
                    
                        for doc in documents {
                            let process = DocumentTypeModel(id: doc.documentTemplate?.process.id ?? 1, label: doc.documentTemplate?.process.label ?? "", shortLabel: doc.documentTemplate?.process.shortLabel ?? ""       , code: doc.documentTemplate?.process.code ?? "")
                            let documentType = DocumentTypeModel(id: doc.documentTemplate?.documentType.id ?? 1, label: doc.documentTemplate?.documentType.label ?? "", shortLabel: doc.documentTemplate?.documentType.shortLabel ?? ""       , code: doc.documentTemplate?.documentType.code ?? "")
                            
                            let documentTemplate = DocumentTemplateModel(uid: doc.documentTemplate?.uid ?? "", label: doc.documentTemplate?.label ?? "", attachment: doc.documentTemplate?.attachment ?? "", documentType: documentType, process: process)
                            
                            let creator = CreatorModel(username: doc.creator?.username ?? "", email: doc.creator?.email ?? "", iin: doc.creator?.iin ?? "", name: doc.creator?.name ?? "", familyName: doc.creator?.familyName ?? "", mobilePhone: doc.creator?.mobilePhone ?? "", patronymic: doc.creator?.patronymic ?? "", avatarUrl: doc.creator?.avatarUrl ?? "")
                            documentsArray.append(
                                
                                DocumentsModel(uid: doc.uid ?? "", label: doc.label ?? "N/A", description: doc.description ?? "", documentTemplate: documentTemplate, creator: creator)
                            )
                        }
                        
                        self.delegate?.didUpdateData(self, models: documentsArray)                    } else if code >= 400 {
                        self.delegate?.didFailWithError(error: "error occured")
                    }
                }
            } catch {
                print(error)
                self.delegate?.didFailWithError(error: error.localizedDescription)
            }
    }
}
    
    func deleteDocumentRequest(index: Int) {
        Doc.documentsList.remove(at: index)
        self.delegate?.shouldUpdateUI(status: true)
//        let token = defaults.string(forKey: "token")!
//        let headers: HTTPHeaders = [
//            "Authorization": "Bearer " + token
//        ]
//
//        let request = AF.request("http://localhost:8080/api/v1/dicts/documents/\(id)", method: .delete, headers: headers).response {
//            (responseData) in
//            do {
//                if let code = responseData.response?.statusCode {
//
//                    if code == 200 {
//                        self.delegate?.shouldUpdateUI(status: true)
//
//                    } else if code >= 400 {
//                        self.delegate?.didFailWithError(error: "error occured")
//                    }
//                }
//            } catch {
//                print(error)
//                self.delegate?.didFailWithError(error: error.localizedDescription)
//            }
//        }
//        request.responseJSON { (data) in
//            print(data)
//        }
    }
    
    func saveDocumentRequest() {
        let token = defaults.string(forKey: "token")!
        let headers: HTTPHeaders = [
            "Authorization": "Bearer " + token
        ]
        
        let request = AF.request("http://localhost:8080/api/v1/dicts/documents/", method: .delete, headers: headers).response {
            (responseData) in
            do {
                if let code = responseData.response?.statusCode {
                                
                    if code == 200 {
                        self.delegate?.shouldUpdateUI(status: true)
                        
                    } else if code >= 400 {
                        self.delegate?.didFailWithError(error: "error occured")
                    }
                }
            } catch {
                print(error)
                self.delegate?.didFailWithError(error: error.localizedDescription)
            }
        }
        request.responseJSON { (data) in
            print(data)
        }
    }
    
    func getDocumentTemplate() {
        let token = defaults.string(forKey: "token")!
        let headers: HTTPHeaders = [
            "Authorization": "Bearer " + token
        ]
        
        let request = AF.request("http://localhost:8080/api/v1/dicts/document-templates/", method: .get, headers: headers).response {
            (responseData) in
            do {
                guard let data = responseData.data else {return}
                if let code = responseData.response?.statusCode {
//                    DocumentTemplateData
                    let decoder = JSONDecoder()
                    let documents = try decoder.decode([DocumentTemplateData].self, from: data)
                    var documentsArray: [DocumentTemplateModel] = []
                    
                    
                    for doc in documents {
                        documentsArray.append(DocumentTemplateModel(uid: doc.uid ?? "", label: doc.label, attachment: doc.attachment, documentType: DocumentTypeModel(id: doc.documentType.id, label: doc.documentType.label, shortLabel: doc.documentType.shortLabel, code: doc.documentType.code), process: DocumentTypeModel(id: doc.process.id, label: doc.process.label, shortLabel: doc.process.shortLabel, code: doc.process.code))
                        )
                    }
                    if code == 200 {
                        self.delegate?.didGetTemplates(self, models: documentsArray)
                        
                    } else if code >= 400 {
                        self.delegate?.didFailWithError(error: "error occured")
                    }
                }
            } catch {
                print(error)
                self.delegate?.didFailWithError(error: error.localizedDescription)
            }
        }
        request.responseJSON { (data) in
            print(data)
        }
    }
    
}
