//
//  Item.swift
//  ois-ios
//
//  Created by Alikhan Nursapayev on 04.05.2022.
//

import Foundation

struct Item: Identifiable {
    let id = UUID()
    let title: String
    let children: [Item]?
}
