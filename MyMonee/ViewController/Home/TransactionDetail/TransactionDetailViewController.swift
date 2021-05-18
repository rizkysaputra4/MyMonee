//
//  TransactionDetailViewController.swift
//  MyMonee
//
//  Created by Rizky Saputra on 16/05/21.
//

import UIKit

class TransactionDetailViewController: UIViewController {

    @IBOutlet weak var transactionTypeView: UIView!
    @IBOutlet weak var transactionTypeImg: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var transactionNominalLabel: UILabel!
    @IBOutlet weak var transactionId: UILabel!
    @IBOutlet weak var transactionDate: UILabel!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var editTransactionBtn: UIButton!
    
    var thisRow: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        backButton.layer.borderWidth = 2
        backButton.layer.borderColor = #colorLiteral(red: 0.3137254902, green: 0.4117647059, blue: 0.7215686275, alpha: 1)
        // Do any additional setup after loading the view.
        loadData()
    }
    
    @IBAction func backPressed(_ sender: Any) {
        navigationController?.popViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func editPressed(_ sender: Any) {
        let editTransactionPage = EditTransactionViewController(nibName: "EditTransactionViewController", bundle: nil)
        editTransactionPage.thisRow = self.thisRow
        self.navigationController?.pushViewController(editTransactionPage, animated: true)
    }
    
    func loadData() {
        self.descriptionLabel.text = userData.transactions[thisRow!].description
        loadArrowIcon()
        transactionId.text = userData.transactions[thisRow!].uuid
        transactionDate.text = userData.transactions[thisRow!].date
    }
    
    func loadArrowIcon() {
        let total = userData.transactions[thisRow!].transactionLabel()
        if userData.transactions[thisRow!].type == .income {
            transactionTypeView.layer.backgroundColor = #colorLiteral(red: 0.1294117647, green: 0.5882352941, blue: 0.3254901961, alpha: 0.2)
            transactionTypeImg.image = UIImage(named: "arrow_upward_24px")
            self.transactionNominalLabel.text = "+ \(total)"
            self.transactionNominalLabel.textColor = #colorLiteral(red: 0.1294117647, green: 0.5882352941, blue: 0.3254901961, alpha: 1)
            
        } else if userData.transactions[thisRow!].type == .outcome {
            transactionTypeView.layer.backgroundColor = #colorLiteral(red: 0.9215686275, green: 0.3411764706, blue: 0.3411764706, alpha: 0.2)
            transactionTypeImg.image = UIImage(named: "arrow_downward_24px")
            self.transactionNominalLabel.text = "- \(total)"
            self.transactionNominalLabel.textColor = #colorLiteral(red: 0.9215686275, green: 0.3411764706, blue: 0.3411764706, alpha: 1)
        }
    }
}
