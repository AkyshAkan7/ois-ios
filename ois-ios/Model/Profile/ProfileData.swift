//
//  ProfileData.swift
//  ois-ios
//
//  Created by Alikhan Nursapayev on 17.06.2022.
//

import Foundation


struct ProfileData: Codable {
    let username: String
    let email: String
    let fullname: String
    let homeAddress: String?
    let iin: String?
}
