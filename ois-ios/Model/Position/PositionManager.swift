//
//  PositionManager.swift
//  ois-ios
//
//  Created by Alikhan Nursapayev on 11.06.2022.
//

import Foundation
import Alamofire


protocol PositionManagerDelegate {
    func didUpdateData(_ positionManager: PositionManager, models: [PositionModel])
    func didSavePosition(_ positionManager: PositionManager, status: Bool)
    func didFailWithError(error: String)
}

struct PositionManager {
    
    let defaults = UserDefaults.standard
    var delegate: PositionManagerDelegate?
    
    func performRequest() {
        let token = defaults.string(forKey: "token")!
        let headers: HTTPHeaders = [
            "Authorization": "Bearer " + token
        ]
        
        let request = AF.request("http://localhost:8080/api/v1/dicts/position", method: .get, headers: headers).response {
            (responseData) in
            guard let data = responseData.data else {return}
            do {
                if let code = responseData.response?.statusCode {
                    let decoder = JSONDecoder()
                    let positions = try decoder.decode([PositionData].self, from: data)
                    
                    if code == 200 {
                        
                        var positionsArray: [PositionModel] = []
                    
                        for position in positions {
                            positionsArray.append(
                                PositionModel(id: position.id, label: position.label ?? "N/A", code: position.code)
                            )
                            
                        }
                        
                        self.delegate?.didUpdateData(self, models: positionsArray)                    } else if code >= 400 {
                        self.delegate?.didFailWithError(error: "error occured")
                    }
                }
            } catch {
                print(error)
                self.delegate?.didFailWithError(error: error.localizedDescription)
            }
        }
    }
    
    func createPosition(position: String, code: String) {
print("Loading")
        let token = defaults.string(forKey: "token")!
        let headers: HTTPHeaders = [
            "Authorization": "Bearer " + token
        ]
        let parameters: [String: Any] = [
            "label": "\(position)",
            "code": "\(code)",
        ]
        
        let request = AF.request("http://localhost:8080/api/v1/dicts/position", method: .post, parameters: parameters,encoding: JSONEncoding.default, headers: headers).response {
            (responseData) in
            guard let data = responseData.data else {return}
            do {
                if let code = responseData.response?.statusCode {                   
                    
                    self.delegate?.didSavePosition(self, status: true)
                    
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
