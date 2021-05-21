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
    @IBOutlet weak var incomeLabel: UILabel!
    @IBOutlet weak var outcomeLabel: UILabel!
    @IBOutlet weak var emptyTransactionView: NotFoundView!
    @IBOutlet weak var transactionTable: UITableView!
    @IBOutlet weak var greetingsLabel: UILabel!
    @IBOutlet weak var transactionTableView: UITableView!
    
    let child = SpinnerViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.isNavigationBarHidden = true
        startLoading()
        NetworkService().loadTransaction { (transactionLoaded) in
            DispatchQueue.main.async {
                userData.transactions = transactionLoaded
                self.transactionTable.reloadData()
//                Toast.show(message: "loaded", controller: self)
                self.stopLoading()
            }
        }
        self.loadData()
        self.loadStyle()
        self.registerHomeLoadNotif()
        self.loadEmptyTable()
        self.loadTableView()
    }
    
    func startLoading() {
        self.tabBarController?.tabBar.isHidden = true
        addChild(child)
        child.view.frame = view.frame
        view.addSubview(child.view)
        child.didMove(toParent: self)
    }
    
    func stopLoading() {
        child.willMove(toParent: nil)
        child.view.removeFromSuperview()
        child.removeFromParent()
        self.tabBarController?.tabBar.isHidden = false
      
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userData.transactions.count
    }
    
    func loadTableView() {
        let tableNib = UINib(nibName: String(describing: TransactionViewController.self), bundle: nil)
        registerCellToTable()
        transactionTableView.register(tableNib, forCellReuseIdentifier: String(describing: TransactionViewController.self))
        transactionTableView.delegate = self
        transactionTableView.dataSource = self
        
        transactionTableView.reloadData()
    }
    
    func registerCellToTable() {
        let uiNib = UINib(nibName: String(describing: TransactionTableViewCell.self), bundle: nil)
        
        transactionTableView.register(uiNib, forCellReuseIdentifier: String(describing: TransactionTableViewCell.self))
    }
    
    func registerHomeLoadNotif() {
        NotificationCenter.default.addObserver(self, selector: #selector(reloadData), name: NSNotification.Name(rawValue: "load"), object: nil)
    }

    @objc func reloadData() {
        self.transactionTableView.reloadData()
        self.loadData()
        self.viewDidLoad()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let theCell = tableView.dequeueReusableCell(
            withIdentifier: String(describing: TransactionTableViewCell.self),
            for: indexPath
        ) as? TransactionTableViewCell
        
        guard let cell = theCell else {
            return UITableViewCell()
        }
       
        return loadCell(cell: cell, indexPath: indexPath)
    }
    
    func loadCell(cell: TransactionTableViewCell, indexPath: IndexPath) -> TransactionTableViewCell {
        let total = userData.transactions[indexPath.row].currencyToString()
        
        cell.descriptionLabel.text = userData.transactions[indexPath.row].description
        cell.date.text = userData.transactions[indexPath.row].dateToString()
        cell.thisRow = indexPath.row
        
        if userData.transactions[indexPath.row].type == .income {
            cell.arrowBackground.backgroundColor = #colorLiteral(red: 0.1294117647, green: 0.5882352941, blue: 0.3254901961, alpha: 0.2)
            cell.arrowImg.image = UIImage(named: "arrow_upward_24px")
            cell.total.text = "+ \(total)"
            cell.total.textColor = #colorLiteral(red: 0.1294117647, green: 0.5882352941, blue: 0.3254901961, alpha: 1)
        } else if userData.transactions[indexPath.row].type == .outcome {
            cell.arrowBackground.backgroundColor = #colorLiteral(red: 0.9215686275, green: 0.3411764706, blue: 0.3411764706, alpha: 0.2)
            cell.arrowImg.image = UIImage(named: "arrow_downward_24px")
            cell.total.text = "- \(total)"
            cell.total.textColor = #colorLiteral(red: 0.9215686275, green: 0.3411764706, blue: 0.3411764706, alpha: 1)
        }
        
        cell.cellDelegate = self
        
        return cell
    }
    
    @IBAction func newTransaction(_ sender: Any) {
       pushToAddNewPage()
    }
    
    func pushToAddNewPage() {
        let newTransactionPage = AddTransactionViewController(nibName: "AddTransactionViewController", bundle: nil)
        newTransactionPage.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(newTransactionPage, animated: true)
    }
    
    func loadStyle() {
        saldoView.layer.cornerRadius = 8
        self.transactionTableView.separatorStyle = .none
    }
    
    func loadData() {
        
        incomeLabel.text = userData.countTotalInString(type: .income)
        outcomeLabel.text = userData.countTotalInString(type: .outcome)
        balanceLabel.text = userData.user.currencyToString()
        emptyTransactionView.isHidden = true
        emptyTransactionView.addButton.setTitle("Tambah Penggunaan", for: .normal)
        if userData.transactions.isEmpty {
            transactionTable.isHidden = true
            emptyTransactionView.isHidden = false
        } else {
            transactionTable.isHidden = false
            emptyTransactionView.isHidden = true
        }
        
        greetingsLabel.text = "Selamat \(currentTime()),"
        
        nameLabel.text = userData.user.name
        
    }
    
    func loadEmptyTable() {
        emptyTransactionView.navigationDelegate = self
        emptyTransactionView.textViewArea.text = "Data kamu kosong, yuk mulai catatan kamu!"
    }
}

extension HomeViewController: CellDelegate, Navigations {
    
    func deleteDream(thisRow: Int) {
        return
    }
    
    func archievedDream(thisRow: Int) {
        return
    }

    func toAddNewPage() {
        pushToAddNewPage()
    }
    
    func toDetailPage(thisRow: Int) {
        
        let dreamDetailPage = TransactionDetailViewController(nibName: "TransactionDetailViewController", bundle: nil)
        dreamDetailPage.thisRow = thisRow
        dreamDetailPage.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(dreamDetailPage, animated: true)
    }
    
}
