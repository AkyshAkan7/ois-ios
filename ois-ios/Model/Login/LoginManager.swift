//
//  LoginManager.swift
//  ois-ios
//
//

import Foundation
import Alamofire


protocol LoginManagerDelegate {
    func didUpdateToken(_ loginManager: LoginManager, token: String)
    func didFailWitherror(error: String)
}

struct LoginManager {
    
    let defaults = UserDefaults.standard
    var delegate: LoginManagerDelegate?
    
    func performRequest(with urlString: String, email: String, password: String) {
        let parameters: [String: Any] = [
            "username" : "\(email)",
            "password" : "\(password)"
        ]
        
        let request = AF.request("http://localhost:8080/api/v1/auth/signin", method: .post, parameters: parameters, encoding: JSONEncoding.default).response {
            (responseData) in
            guard let data = responseData.data else {return}
            do {
                if let code = responseData.response?.statusCode {
                    let decoder = JSONDecoder()
                    let login = try decoder.decode(LoginData.self, from: data)
                    
                    if code == 200 {
                        
                        print(login)
                        
                        self.defaults.set("\(login.accessToken!)", forKey: "token")
                        self.delegate?.didUpdateToken(self, token: login.accessToken ?? "")
                    } else if code >= 400 {
                        self.delegate?.didFailWitherror(error: login.message ?? "")
                    }
                }
            } catch {
                print(error)
                self.delegate?.didFailWitherror(error: error.localizedDescription)
            }
    }
}
    
    func parseJSON(_ weatherData: Data) -> LoginModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(LoginData.self, from: weatherData)
            let token = decodedData.accessToken
            
            let login = LoginModel(token: token ?? "")
            
            return login
        } catch {
//            self.delegate?.didFailWitherror(error: error)
            return nil
        }
    }
}
