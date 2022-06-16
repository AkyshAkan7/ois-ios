//
//  ViewController.swift
//  ois-ios
//
//

import UIKit
import Alamofire
import NotificationBanner

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    var loginManager = LoginManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        loginManager.delegate = self
    }

    @IBAction func loginPressed(_ sender: Any) {
        loginManager.performRequest(with: "", email: emailTextField.text ?? "", password: passwordTextField.text ?? "")
    }
    
    @IBAction func passwordShowPressed(_ sender: Any) {
        passwordTextField.isSecureTextEntry = !passwordTextField.isSecureTextEntry
    }
}


extension LoginViewController: LoginManagerDelegate {
    func didUpdateToken(_ loginManager: LoginManager, token: String) {
        performSegue(withIdentifier: "LoginToMain", sender: self)
    }
    
    func didFailWitherror(error: String) {
        showNotificationBanner(bannerStyle: .errorMessage, bannerLocation: .Top,
                                       messageTitle: "Ошибка", messageContent: "Неверные данные")

    }
    
    
}


extension LoginViewController: NotificationBannerDelegate {
    func notificationBannerClick(_ view: NotificationBannerView) {
        dissmissBanner { Success in _ = Bool()
            if(Success) {
                
            }
        }
    }
    
    
}
