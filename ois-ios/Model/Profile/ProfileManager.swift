//
//  PatientManager.swift
//  ois-ios
//

import Foundation

import Alamofire

protocol ProfileManagerDelegate {
    
    func didLoadData(profile: ProfileData)
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
        
        let request = AF.request("http://localhost:8080/api/v1/users/me", method: .get, headers: headers).response {
            (responseData) in
            guard let data = responseData.data else {return}
            do {
                if let code = responseData.response?.statusCode {
                    let decoder = JSONDecoder()
                    let profile = try decoder.decode(ProfileData.self, from: data)
                    
                    if code == 200 {                        
                        
                        self.delegate?.didLoadData(profile: profile)
                        
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
