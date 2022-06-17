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
    
    
    var documentsManager = DocumentsManager()
    var selected: DocumentsModel? = nil
    var selectedIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "DefaultCell")
        documentsManager.delegate = self
//        documentsManager.performRequest()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toSpecificDocument"{
            let destinationVC = segue.destination as! SpecificDocumentViewController
            destinationVC.document = selected
            destinationVC.index = selectedIndex
        }
    }
}


extension DocumentsViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Doc.documentsList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DefaultCell") as! TableViewCell
        
        cell.initialize(mainLabel: Doc.documentsList[indexPath.row].label ?? "N/A", secondLabel: Doc.documentsList[indexPath.row].creator.username ?? "N/A", thirdLabel: Doc.documentsList[indexPath.row].creator.name ?? "N/A", image: Doc.documentsList[indexPath.row].creator.avatarUrl ?? "")
            
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selected = Doc.documentsList[indexPath.row]
        selectedIndex = indexPath.row
        performSegue(withIdentifier: "toSpecificDocument", sender: self)
    }
}



extension DocumentsViewController: DocumentsManagerDelegate {
    func didGetTemplates(_ positionManager: DocumentsManager, models: [DocumentTemplateModel]) {
        
    }
    
    func shouldUpdateUI(status: Bool) {
        tableView.reloadData()
    }
    
    func didUpdateData(_ positionManager: DocumentsManager, models: [DocumentsModel]) {
        tableView.reloadData()
    }
    
    func didFailWithError(error: String) {
        print(error)
    }
    
    
}
