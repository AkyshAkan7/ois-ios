//
//  PatientData.swift
//  ois-ios
//
//  Created by Alikhan Nursapayev on 11.06.2022.
//

import Foundation

struct PatientData : Codable {
    let id: Int
    let relativeFullName: String?
    let relativePhoneNumber: String?
    let user: Creator?
}
