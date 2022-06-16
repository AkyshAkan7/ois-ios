//
//  PatientManager.swift
//  ois-ios
//

import Foundation

import Alamofire

protocol ProfileManagerDelegate {
    
    func didSLoadData(status: Bool)
    func didDelete(status: Bool)
    
    
    func didFailWithError(error: String)
}

struct ProfileManager {
    
    var defaults = UserDefaults.standard
    var delegate: ProfileManagerDelegate?
    
    func performRequest() {
        
        let token = defaults.string(forKey: "token")!
        let headers: HTTPHeaders = [
            "Authorization": "Bearer " + token
        ]
        
        let request = AF.request("http://localhost:8080/api/v1/dict/patients", method: .get, headers: headers).response {
            (responseData) in
            guard let data = responseData.data else {return}
            do {
                if let code = responseData.response?.statusCode {
                    let decoder = JSONDecoder()
                    let patients = try decoder.decode([PatientData].self, from: data)
                    
                    if code == 200 {
                        
                        var patientArray: [PatientModel] = []
                    
                        for patient in patients {
                            patientArray.append(
                            
                                PatientModel(id: patient.id, relativeFullName: patient.relativeFullName, relativePhoneNumber: patient.relativePhoneNumber, user: patient.user ?? nil)
                            )
                        }
                        
                        self.delegate?.didSLoadData(status: true)
                        
                    } else if code >= 400 {
                        self.delegate?.didFailWithError(error: "error occured")
                    }
                }
            } catch {
                print(error)
                self.delegate?.didFailWithError(error: error.localizedDescription)
            }
    }
}
    
}
