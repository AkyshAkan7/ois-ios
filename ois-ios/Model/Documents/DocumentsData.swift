//
//  DocumentsData.swift
//  ois-ios
//
//  Created by Alikhan Nursapayev on 11.06.2022.
//

import Foundation


struct DocumentsData: Codable {
    let uid: String?
    let label: String?
    let description: String?
    let documentTemplate: DocumentTemplateData?
    let creator: Creator?
}

struct DocumentTemplateData: Codable {
    let uid: String?
    let label: String
    let attachment: String
    let documentType: DocumentTypeData
    let process: DocumentTypeData
    
}

struct DocumentTypeData: Codable {
    let id: Int
    let label: String
    let shortLabel: String
    let code: String
}

struct Creator: Codable {
    let username: String
    let email: String
    let iin: String
    let name: String
    let familyName: String
    let mobilePhone: String?
    let patronymic: String
    let avatarUrl: String
    let nationality: NationalityData?
    let socialStatus: NationalityData?
    let sex: NationalityData?
    let position: NationalityData?
}

struct NationalityData: Codable {
    let id: Int
    let label: String
    let code: String
}
