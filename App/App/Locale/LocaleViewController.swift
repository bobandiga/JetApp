//
//  LocaleViewController.swift
//  App
//
//  Created by Максим Шаптала on 01.02.2021.
//

import UIKit

final class LocaleViewController: BaseMVPViewController<LocalePresenterProtocol, LocaleView> {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter = LocalePresenter()
        presenter?.view = self
        
        customView.delegate = self
        customView.dataSource = self
        customView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
}

extension LocaleViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.dataSource.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? UITableViewCell else {
            fatalError()
        }
        cell.textLabel?.text = presenter?.dataSource[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.selectRow(index: indexPath.row)
    }
    
}

extension LocaleViewController: LocaleViewProtocol {
    func loading() {
        loaderView.show(customView)
    }
    
    func finishLoading() {
        loaderView.hide()
    }
    
    
}
