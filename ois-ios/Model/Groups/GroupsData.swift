//
//  GroupsData.swift
//  ois-ios
//
//  Created by Alikhan Nursapayev on 09.06.2022.
//

import Foundation
struct GroupsData: Codable {
    let groupname : String?
    let label: String?
    let description: String?
    let tentent: Int?
    let permissions: [String]?
}
