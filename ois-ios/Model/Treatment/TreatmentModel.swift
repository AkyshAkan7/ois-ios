//
//  TreatmentModel.swift
//  ois-ios
//
//  Created by Alikhan Nursapayev on 17.06.2022.
//

import Foundation


struct TreatmentModel {
    let uid: String
    let description: String
    let startDate: String
    let endDate: String
}

struct TreatData {
    static var treatments = [
        TreatmentModel(uid: "001", description: "Лечение", startDate: "12.06.2022", endDate: "13.07.2022"),
        TreatmentModel(uid: "002", description: "Лечение Рака", startDate: "12.06.2022", endDate: "13.07.2022"),
        TreatmentModel(uid: "003", description: "Лечение ангины", startDate: "12.06.2022", endDate: "13.07.2022")
]
    
}
