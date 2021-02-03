//
//  OccuaranceViewController.swift
//  App
//
//  Created by Максим Шаптала on 03.02.2021.
//

import UIKit
import CoreModels

final class OccuaranceViewController: UITableViewController {
    
    var dataSource: [CharSet] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Character")
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Character", for: indexPath)
        
        cell.textLabel?.text = "\" \(dataSource[indexPath.item].char) \" repeat \(dataSource[indexPath.item].count) times"
        
        return cell
        
    }
    
}
