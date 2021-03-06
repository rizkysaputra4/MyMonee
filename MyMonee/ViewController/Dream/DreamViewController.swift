//
//  DreamViewController.swift
//  MyMonee
//
//  Created by Rizky Saputra on 12/05/21.
//

import UIKit

class DreamViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var dreamTable: UITableView!
    @IBOutlet weak var emptyDataView: NotFoundView!
    @IBOutlet weak var dreamTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        
        emptyDataView.navigationDelegate = self
        
        let uiNib = UINib(nibName: String(describing: DreamTableViewCell.self), bundle: nil)
        dreamTable.register(uiNib, forCellReuseIdentifier: String(describing: DreamTableViewCell.self))
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(reloadData), name: NSNotification.Name(rawValue: "dream updated"),
            object: nil
        )
        
        loadData()
        encodeAndSaveToLocal(data: userData)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userData.dreams.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let theCell = tableView.dequeueReusableCell(
            withIdentifier: String(describing: DreamTableViewCell.self),
            for: indexPath
        ) as? DreamTableViewCell
        
        guard let cell = theCell else {
            print("cell error")
            return UITableViewCell()
        }
        
        cell.descriptionLabel.text = userData.dreams[indexPath.row].description
        cell.progressLabel.text = userData.getDreamProgressLabel(dreamIndex: indexPath.row)
        cell.currentRow = indexPath.row
        
        let dreamProgress = userData.user.balance / userData.dreams[indexPath.row].target
        cell.progress.progress = Float(dreamProgress)
        cell.cellDelegate = self
        return cell
    }

    @IBAction func newDream(_ sender: Any) {
        pushToNewDreamPage()
    }
    
    func pushToNewDreamPage() {
        let newDreamPage = AddDreamViewController(nibName: "AddDreamViewController", bundle: nil)
        newDreamPage.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(newDreamPage, animated: true)
    }
    
    @objc func reloadData() {
        self.dreamTable.reloadData()
        self.loadData()
    }
    
    func loadData() {
        loadEmptyDataView()
        loadTable()
    }
    
    func loadTable() {
        let tableNib = UINib(nibName: String(describing: dreamTable.self), bundle: nil)
        
        dreamTable.register(tableNib, forCellReuseIdentifier: String(describing: TransactionViewController.self))
        
        dreamTable.delegate = self
        dreamTable.dataSource = self
        
        dreamTable.backgroundColor = #colorLiteral(red: 0.8980392157, green: 0.8980392157, blue: 0.9176470588, alpha: 1)
        self.dreamTable.separatorStyle = .none
    }
    
    func loadEmptyDataView() {
        emptyDataView.textViewArea.text = "Data kamu kosong, yuk mulai buat impian kamu!"
        emptyDataView.contentView.backgroundColor = UIColor(named: "background")
        emptyDataView.textViewArea.backgroundColor = UIColor(named: "background")
        emptyDataView.isHidden = true
        if userData.dreams.isEmpty {
            dreamTableView.isHidden = true
            emptyDataView.isHidden = false
        } else {
            dreamTableView.isHidden = false
            emptyDataView.isHidden = true
        }
        emptyDataView.addButton.setTitle("Tambah Impian", for: .normal)
    }
}

extension DreamViewController: CellDelegate, Navigations {
    
    func deleteDream(thisRow: Int) {
        userData.dreams.remove(at: thisRow)
        encodeAndSaveToLocal(data: userData)
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "dream updated"), object: nil)
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "load"), object: nil)
    }
    
    func archievedDream(thisRow: Int) {
        let currentDream = userData.dreams[thisRow]
        if userData.user.balance >= currentDream.target {
            var newTransaction = Transaction()
            newTransaction.description = currentDream.description
            newTransaction.total = currentDream.target
            newTransaction.date = Date()
            newTransaction.uuid = randomString(length: 8)
            newTransaction.type = .outcome
            
            userData.transactions.append(newTransaction)
            userData.dreams.remove(at: thisRow)
            userData.updateBalance(num: newTransaction.total!, type: newTransaction.type!)
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "dream updated"), object: nil)
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "load"), object: nil)
            
            encodeAndSaveToLocal(data: userData)
        }
    }
    
    func toAddNewPage() {
        pushToNewDreamPage()
    }
    
    func toDetailPage(thisRow: Int) {
        let dreamDetailPage = DreamDetailViewController(nibName: "DreamDetailViewController", bundle: nil)
        dreamDetailPage.hidesBottomBarWhenPushed = true
        dreamDetailPage.thisRow = thisRow
        self.navigationController?.pushViewController(dreamDetailPage, animated: true)
    }
    
}
