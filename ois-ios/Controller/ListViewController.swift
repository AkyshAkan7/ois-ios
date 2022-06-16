//
//  ListViewController.swift
//  ois-ios
//
//  Created by Alikhan Nursapayev on 27.05.2022.
//

import UIKit
import SwiftUI

class ListViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        var child = UIHostingController(rootView: MainScreen(items: Item.stubs))
        child.view.translatesAutoresizingMaskIntoConstraints = false
        child.view.frame = self.view.bounds

        self.view.addSubview(child.view)
        self.addChild(child)

        print("hii")
    }
    

}
