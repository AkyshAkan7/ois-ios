//
//  PatientManager.swift
//  ois-ios
//

import Foundation

import Alamofire

protocol PatientManagerDelegate {
    
    func didUpdateData(_ positionManager: PatientManager, models: [PatientModel])
    func didSaveData(status: Bool)
    func didDelete(status: Bool)
    
    
    func didFailWithError(error: String)
}

struct PatientManager {
    
    var defaults = UserDefaults.standard
    var delegate: PatientManagerDelegate?
    
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
                        
                        self.delegate?.didUpdateData(self, models: patientArray)                    } else if code >= 400 {
                        self.delegate?.didFailWithError(error: "error occured")
                    }
                }
            } catch {
                print(error)
                self.delegate?.didFailWithError(error: error.localizedDescription)
            }
    }
}
    
    func createPatientRequest(relativeFullName: String, relativePhoneNumber: String, username: String) {
        
        let token = defaults.string(forKey: "token")!
        let headers: HTTPHeaders = [
            "Authorization": "Bearer " + token
        ]
        
        
        let userPar: Parameters =  [
            "username": "\(username)"
        ]
        let parameters: Parameters = [
            "relativeFullName": "\(relativeFullName)",
            "relativePhoneNumber": "\(relativePhoneNumber)",
            "user": "\(userPar)"
        ]
        
        let request = AF.request("http://localhost:8080/api/v1/dict/patients", method: .post, parameters: parameters,encoding: JSONEncoding.default, headers: headers).response {
            (responseData) in
//            guard let data = responseData.data else {return}
            do {
                if let code = responseData.response?.statusCode {
                    
                    if code < 400 {
                        self.delegate?.didSaveData(status: true)
                    } else {
                        self.delegate?.didFailWithError(error: "Error occured")
                    }
                    
                }
            } catch {
                print(error)
                self.delegate?.didFailWithError(error: error.localizedDescription)
            }
        }
        request.responseJSON { (data) in
            print(data)
        }
    }
    func deletePatient(id: Int) {
        let token = defaults.string(forKey: "token")!
        let headers: HTTPHeaders = [
            "Authorization": "Bearer " + token
        ]
        
        
        let request = AF.request("http://localhost:8080/api/v1/dict/patients/\(id)", method: .delete,encoding: JSONEncoding.default, headers: headers).response {
            (responseData) in
//            guard let data = responseData.data else {return}
            do {
                if let code = responseData.response?.statusCode {
                    
                    if code < 400 {
                        self.delegate?.didDelete(status: true)
                    } else {
                        self.delegate?.didFailWithError(error: "Error occured")
                    }
                    
                }
            } catch {
                print(error)
                self.delegate?.didFailWithError(error: error.localizedDescription)
            }
        }
        request.responseJSON { (data) in
            print(data)
        }
    }
}
