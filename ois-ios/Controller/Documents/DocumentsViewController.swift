//
//  DocumentsViewController.swift
//  ois-ios
//
//  Created by Alikhan Nursapayev on 11.06.2022.
//

import UIKit
import SwiftUI

class DocumentsViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var documents: [DocumentsModel]? = nil
    
    var documentsManager = DocumentsManager()
    var selected: DocumentsModel? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "DefaultCell")
        documentsManager.delegate = self
        documentsManager.performRequest()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toSpecificDocument"{
            let destinationVC = segue.destination as! SpecificDocumentViewController
            destinationVC.document = selected
        }
    }
}


extension DocumentsViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return documents?.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DefaultCell") as! TableViewCell
        
        cell.initialize(mainLabel: documents?[indexPath.row].label ?? "N/A", secondLabel: documents?[indexPath.row].creator.username ?? "N/A", thirdLabel: documents?[indexPath.row].creator.name ?? "N/A", image: documents?[indexPath.row].creator.avatarUrl ?? "")
            
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selected = documents?[indexPath.row]
        performSegue(withIdentifier: "toSpecificDocument", sender: self)
    }
}



extension DocumentsViewController: DocumentsManagerDelegate {
    func shouldUpdateUI(status: Bool) {
        documentsManager.performRequest()
    }
    
    func didUpdateData(_ positionManager: DocumentsManager, models: [DocumentsModel]) {
        self.documents = models
        tableView.reloadData()
    }
    
    func didFailWithError(error: String) {
        print(error)
    }
    
    
}
