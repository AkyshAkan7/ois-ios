//
//  CreatePoistionViewController.swift
//  ois-ios
//
//  Created by Alikhan Nursapayev on 11.06.2022.
//

import UIKit


protocol createPositionDelegate {
    func didSaveData(succes: Bool)
}


class CreatePoistionViewController: UIViewController {
    @IBOutlet weak var positionTextField: UITextField!
    @IBOutlet weak var codeTextField: UITextField!
    
    var delegate: createPositionDelegate?
    var positionManager = PositionManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        positionManager.delegate = self
    }

    @IBAction func saveButtonPressed(_ sender: Any) {
            
        positionManager.createPosition(position: (positionTextField?.text!)!, code: (codeTextField?.text!)!)
        
    }
}

extension CreatePoistionViewController: PositionManagerDelegate {
    func didUpdateData(_ positionManager: PositionManager, models: [PositionModel]) {
        
    }
    
    func didSavePosition(_ positionManager: PositionManager, status: Bool) {
        print("Called you")
        delegate?.didSaveData(succes: true)
        self.navigationController?.popViewController(animated: true)
    }
    
    func didFailWithError(error: String) {
        
    }
}
