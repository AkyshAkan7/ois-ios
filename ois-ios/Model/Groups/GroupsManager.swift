//
//  GroupsManager.swift
//  ois-ios
//
//  Created by Alikhan Nursapayev on 09.06.2022.
//

import Foundation
import Alamofire


protocol GroupsManagerDelegate {
    func didUpdateData(_ groupsManager: GroupsManager, models: [GroupsModel])
    func didCreateGroup(succes: Bool)
    func didFailWithError(error: String)
}

struct GroupsManager {
    
    let defaults = UserDefaults.standard
    var delegate: GroupsManagerDelegate?
    
    func performRequest(with urlString: String, email: String, password: String) {
        
        let token = defaults.string(forKey: "token")!
        let headers: HTTPHeaders = [
            "Authorization": "Bearer " + token
        ]
        print(headers)
        
        let request = AF.request("http://localhost:8080/api/v1/groups", method: .get, headers: headers).response {
            (responseData) in
            guard let data = responseData.data else {return}
            do {
                if let code = responseData.response?.statusCode {
                    let decoder = JSONDecoder()
                    let groups = try decoder.decode([GroupsData].self, from: data)
                    
                    if code == 200 {
                        
                        var groupsArray: [GroupsModel] = []
                    
                        for group in groups {
                            groupsArray.append(GroupsModel(groupname: group.groupname ?? "N/A", label: group.label ?? "N/A", description: group.description ?? "", tentent: group.tentent ?? 1, permissions: group.permissions ?? []))
                        }
                        
                        self.delegate?.didUpdateData(self, models: groupsArray)                    } else if code >= 400 {
                        self.delegate?.didFailWithError(error: "error occured")
                    }
                }
            } catch {
                print(error)
                self.delegate?.didFailWithError(error: error.localizedDescription)
            }
    }
}
    func createGroup(groupname: String, label: String, description: String) {
print("Loading")
        let token = defaults.string(forKey: "token")!
        let headers: HTTPHeaders = [
            "Authorization": "Bearer " + token
        ]
        let parameters: [String: Any] = [
            "groupname": "\(groupname)",
            "label": "\(label)",
            "description": "\(description)",
            "tenant": 1
        ]
        
        let request = AF.request("http://localhost:8080/api/v1/groups", method: .post, parameters: parameters,encoding: JSONEncoding.default, headers: headers).response {
            (responseData) in
            guard let data = responseData.data else {return}
            do {
                self.delegate?.didCreateGroup(succes: true)
                if let code = responseData.response?.statusCode {
                    
                    
                    
                }
            } catch {
                print(error)
                self.delegate?.didFailWithError(error: error.localizedDescription)
                self.delegate?.didCreateGroup(succes: true)
            }
        }
        request.responseJSON { (data) in
            print(data)
        }
        self.delegate?.didCreateGroup(succes: false)

    }
    
    func changeGroup(groupname: String, label: String, description: String) {
print("Loading")
        let token = defaults.string(forKey: "token")!
        let headers: HTTPHeaders = [
            "Authorization": "Bearer " + token
        ]
        let parameters: [String: Any] = [
            "groupname": "\(groupname)",
            "label": "\(label)",
            "description": "\(description)",
            "tenant": 1
        ]
        
        let request = AF.request("http://localhost:8080/api/v1/groups/\(groupname)", method: .put, parameters: parameters,encoding: JSONEncoding.default, headers: headers).response {
            (responseData) in
            guard let data = responseData.data else {return}
            do {
                self.delegate?.didCreateGroup(succes: true)
                if let code = responseData.response?.statusCode {
                    
                    
                    
                }
            } catch {
                print(error)
                self.delegate?.didFailWithError(error: error.localizedDescription)
                self.delegate?.didCreateGroup(succes: true)
            }
        }
        request.responseJSON { (data) in
            print(data)
        }
        self.delegate?.didCreateGroup(succes: false)

    }
    func deleteGroup(groupname: String, label: String, description: String) {
print("Loading")
        let token = defaults.string(forKey: "token")!
        let headers: HTTPHeaders = [
            "Authorization": "Bearer " + token
        ]
        let parameters: [String: Any] = [
            "groupname": "\(groupname)",
            "label": "\(label)",
            "description": "\(description)",
            "tenant": 1
        ]
        
        let request = AF.request("http://localhost:8080/api/v1/groups/\(groupname)", method: .delete, parameters: parameters,encoding: JSONEncoding.default, headers: headers).response {
            (responseData) in
            guard let data = responseData.data else {return}
            do {
                if let code = responseData.response?.statusCode {
                    
                    self.delegate?.didCreateGroup(succes: true)
                    
                }
            } catch {
                print(error)
                self.delegate?.didFailWithError(error: error.localizedDescription)
                self.delegate?.didCreateGroup(succes: true)
            }
        }
        request.responseJSON { (data) in
            print(data)
        }
        self.delegate?.didCreateGroup(succes: true)

    }
}
