//
//  SpecificPositionViewController.swift
//  ois-ios
//
//  Created by Alikhan Nursapayev on 11.06.2022.
//

import UIKit

class SpecificPositionViewController: UIViewController {
    @IBOutlet weak var idTextField: UITextField!
    
    @IBOutlet weak var positionTextField: UITextField!
    @IBOutlet weak var codeTextField: UITextField!
    var position: PositionModel? = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        print(position)
        if let id = position?.id {
            idTextField.text = "\(id)"
        }
        
        positionTextField.text = position?.label
        codeTextField.text = position?.code
    }

}
