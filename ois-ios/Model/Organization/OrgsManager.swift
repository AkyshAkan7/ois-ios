//
//  OrgsManager.swift
//  ois-ios
//
//

import Foundation
import Alamofire


protocol OrgsManagerDelegate {
    func didUpdateData(_ groupsManager: OrgsManager, models: [OrgsModel])
    func didFailWithError(error: String)
}

struct OrgsManager {
    
    let defaults = UserDefaults.standard
    var delegate: OrgsManagerDelegate?
    
    func performRequest() {
        
        let token = defaults.string(forKey: "token")!
        let headers: HTTPHeaders = [
            "Authorization": "Bearer " + token
        ]
        print(headers)
        
        let request = AF.request("http://localhost:8080/api/v1/org-units", method: .get, headers: headers).response {
            (responseData) in
            guard let data = responseData.data else {return}
            do {
                if let code = responseData.response?.statusCode {
                    let decoder = JSONDecoder()
                    let orgs = try decoder.decode([OrgsData].self, from: data)
                    
                    if code == 200 {
                        
                        var orgsArray: [OrgsModel] = []
                    
                        for org in orgs {
                            let manager = ManagerModel(username: org.manager!.username ?? "", email: org.manager!.email, name: org.manager!.name ?? "", avatarUrl: org.manager!.avatarUrl)
                            orgsArray.append(OrgsModel(id: org.id, shortLabel: org.shortLabel ?? "", label: org.label ?? "", index: org.index ?? "", bin: org.bin ?? "", active: org.active, parent: org.parent ?? 0, manager: manager))
                            
                        }
                        
                        self.delegate?.didUpdateData(self, models: orgsArray)                    } else if code >= 400 {
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
