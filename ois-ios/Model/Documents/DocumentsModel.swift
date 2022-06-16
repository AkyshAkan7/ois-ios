//
//  DocumentsModel.swift
//  ois-ios
//
//

import Foundation



struct DocumentsModel {
    let uid: String
    let label: String
    let description: String
    let documentTemplate: DocumentTemplateModel?
    let creator: CreatorModel
}

struct DocumentTemplateModel {
    let uid: String
    let label: String
    let attachment: String
    let documentType: DocumentTypeModel
    let process: DocumentTypeModel
    
}

struct DocumentTypeModel {
    let id: Int
    let label: String
    let shortLabel: String
    let code: String
}

struct CreatorModel {
    let username: String
    let email: String
    let iin: String
    let name: String
    let familyName: String
    let mobilePhone: String?
    let patronymic: String
    let avatarUrl: String
//    let nationality: NationalityModel
//    let socialStatus: NationalityModel
//    let sex: NationalityModel
//    let position: NationalityModel
}

struct NationalityModel: Codable {
    let id: Int
    let label: String
    let code: String
}


struct Doc {
    
    static var documentsList = [
        DocumentsModel(uid: "5678", label: "Document", description: "SomeDocument", documentTemplate: DocumentTemplateModel(uid: "678", label: "template", attachment: "none", documentType: DocumentTypeModel(id: 789, label: "jhjk", shortLabel: "jhjk", code: "234"), process: DocumentTypeModel(id: 2, label: "234", shortLabel: "d", code: "234")), creator: CreatorModel(username: "person", email: "none", iin: "656789", name: "Person", familyName: "Persons", mobilePhone: "98765678", patronymic: "76789", avatarUrl: "avatar.png"))
    ]
}
