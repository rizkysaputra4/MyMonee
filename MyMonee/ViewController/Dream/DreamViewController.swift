//
//  DreamViewController.swift
//  MyMonee
//
//  Created by Rizky Saputra on 12/05/21.
//

import UIKit

class DreamViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var dreamTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        
        let tableNib = UINib(nibName: String(describing: dreamTable.self), bundle: nil)
        
        dreamTable.register(tableNib, forCellReuseIdentifier: String(describing: TransactionViewController.self))
        
        dreamTable.delegate = self
        dreamTable.dataSource = self
        
        let uiNib = UINib(nibName: String(describing: DreamTableViewCell.self), bundle: nil)
        dreamTable.register(uiNib, forCellReuseIdentifier: String(describing: DreamTableViewCell.self))
        
        dreamTable.backgroundColor = #colorLiteral(red: 0.8980392157, green: 0.8980392157, blue: 0.9176470588, alpha: 1)
        self.dreamTable.separatorStyle = .none
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userData.dreams.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: DreamTableViewCell.self), for: indexPath) as! DreamTableViewCell
        cell.descriptionLabel.text = userData.dreams[indexPath.row].description
        cell.progressLabel.text = userData.dreams[indexPath.row].currencyToString()
        cell.currentRow = indexPath.row
        
        let dreamProgress = userData.dreams[indexPath.row].saved / userData.dreams[indexPath.row].target
        cell.progress.progress = Float(dreamProgress)
        
        return cell
    }

}
