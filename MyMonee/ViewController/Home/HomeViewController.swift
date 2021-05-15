//
//  HomeViewController.swift
//  MyMonee
//
//  Created by Rizky Saputra on 12/05/21.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var mainView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var saldoView: UIView!
    @IBOutlet weak var balanceLabel: UILabel!
    
    @IBOutlet weak var transactionTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.isNavigationBarHidden = true
        nameLabel.text = user.name
        balanceLabel.text = "Rp. \(user.currencyToString())"
        
        saldoView.layer.cornerRadius = 8
        
        let tableNib = UINib(nibName: String(describing: TransactionViewController.self), bundle: nil)
        
        transactionTableView.register(tableNib, forCellReuseIdentifier: String(describing: TransactionViewController.self))
        
        transactionTableView.delegate = self
        transactionTableView.dataSource = self
        
        let uiNib = UINib(nibName: String(describing: TransactionTableViewCell.self), bundle: nil)
        transactionTableView.register(uiNib, forCellReuseIdentifier: String(describing: TransactionTableViewCell.self))
        
        self.transactionTableView.separatorStyle = .none
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userData.transactions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: TransactionTableViewCell.self), for: indexPath) as! TransactionTableViewCell
        let transaction = userData.transactions
        let total = transaction[indexPath.row].transactionLabel()
        
        cell.descriptionLabel.text = transaction[indexPath.row].description
        cell.date.text = transaction[indexPath.row].date
        
        if transaction[indexPath.row].type == .income {
            cell.arrowBackground.backgroundColor = #colorLiteral(red: 0.1294117647, green: 0.5882352941, blue: 0.3254901961, alpha: 0.2)
            cell.arrowImg.image = UIImage(named: "arrow_upward_24px")
            cell.total.text = "+ Rp. \(total)"
            cell.total.textColor = #colorLiteral(red: 0.1294117647, green: 0.5882352941, blue: 0.3254901961, alpha: 1)
        } else if transaction[indexPath.row].type == .outcome {
            cell.arrowBackground.backgroundColor = #colorLiteral(red: 0.9215686275, green: 0.3411764706, blue: 0.3411764706, alpha: 0.2)
            cell.arrowImg.image = UIImage(named: "arrow_downward_24px")
            cell.total.text = "- Rp. \(total)"
            cell.total.textColor = #colorLiteral(red: 0.9215686275, green: 0.3411764706, blue: 0.3411764706, alpha: 1)
        }
        
        return cell
    }
    
    @IBAction func newTransaction(_ sender: Any) {
        let newTransactionPage = AddTransactionViewController(nibName: "AddTransactionViewController", bundle: nil)
        
        self.navigationController?.pushViewController(newTransactionPage, animated: true)
    }
}
