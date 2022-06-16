//
//  OrgsData.swift
//  ois-ios
//
//  Created by Alikhan Nursapayev on 10.06.2022.
//

import Foundation
struct OrgsData: Codable {
    let id: Int
    let shortLabel : String?
    let label: String?
    let index: String?
    let bin: String?
    let active: Bool
    let parent: Int?
    let manager: ManagerData?
}


struct ManagerData: Codable {
    let username: String
    let email: String
    let name: String
    let avatarUrl: String
}
