//
//  ProfileViewController.swift
//  ois-ios
//
//  Created by Alikhan Nursapayev on 17.06.2022.
//

import UIKit

class ProfileViewController: UIViewController {
    
    
    @IBOutlet weak var nameTextField: UILabel!
    @IBOutlet weak var emailTextField: UILabel!
    @IBOutlet weak var iinTextField: UILabel!
    var manager = ProfileManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        manager.delegate = self
        manager.performRequest()
    }

}

extension ProfileViewController: ProfileManagerDelegate {
    func didLoadData(profile: ProfileData) {
        nameTextField.text = profile.fullname
        emailTextField.text = profile.email
    }
    
    func didFailWithError(error: String) {
        print(error)
    }
    
    
}
