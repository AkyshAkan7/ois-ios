//
//  DocumentsModel.swift
//  ois-ios
//
//  Created by Alikhan Nursapayev on 11.06.2022.
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
