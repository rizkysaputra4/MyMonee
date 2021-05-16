//
//  EditTransactionViewController.swift
//  MyMonee
//
//  Created by Rizky Saputra on 16/05/21.
//

import UIKit

class EditTransactionViewController: UIViewController {

    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var incomeButton: UIButton!
    @IBOutlet weak var outcomeButton: UIButton!
    @IBOutlet weak var descriptionInput: UITextField!
    @IBOutlet weak var totalInput: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    
    var transaction: Transaction = Transaction()
    var thisRow: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadViewStyle()
        loadDefaultValue()
        isFilled()
        
        descriptionInput.addTarget(self, action: #selector(self.didChange(_:)), for: .editingChanged)
        totalInput.addTarget(self, action: #selector(self.didChange(_:)), for: .editingChanged)
    }
    
    @IBAction func goBack(_ sender: Any) {
        navigationController?.popViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
    }
    
    func isFilled() {
        let isDescriptionEmty = descriptionInput.text?.isEmpty ?? true
        let isTotalEmpty = totalInput.text?.isEmpty ?? true
        let isTransactionTypeEmpty = transaction.type == nil
        print(isDescriptionEmty, isTotalEmpty, isTransactionTypeEmpty)
        if  isDescriptionEmty || isTotalEmpty || isTransactionTypeEmpty {
            saveButton.layer.backgroundColor = #colorLiteral(red: 0.5148796439, green: 0.5535522103, blue: 0.5920764804, alpha: 1)
            saveButton.isEnabled = false
        } else {
            saveButton.layer.backgroundColor = #colorLiteral(red: 0.3137254902, green: 0.4117647059, blue: 0.7215686275, alpha: 1)
            saveButton.isEnabled = true
        }
        
    }
    
    @objc func didChange(_ textField: UITextField) {
             isFilled()
    }
    
   @IBAction func incomeBtnPressed(_ sender: Any) {
        transaction.type = .income
    loadViewStyle()
    incomeButton.radiusBorder(borderWidth: 4, borderColor: #colorLiteral(red: 0.3137254902, green: 0.4117647059, blue: 0.7215686275, alpha: 1))
        isFilled()
    }
    
    @IBAction func outcomeBtnPressed(_ sender: Any) {
        transaction.type = .outcome
        loadViewStyle()
        outcomeButton.radiusBorder(borderWidth: 4, borderColor: #colorLiteral(red: 0.3137254902, green: 0.4117647059, blue: 0.7215686275, alpha: 1))
        isFilled()
    }
    
    @IBAction func savePressed(_ sender: Any) {
        self.transaction.description = descriptionInput.text
        self.transaction.total = Double(totalInput.text!) ?? 0
        transactions[thisRow!] = self.transaction
        userData.transactions = transactions
        updateUserBalance(num: self.transaction.total!, type: self.transaction.type!)
       
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "load"), object: nil)
        self.navigationController?.popViewController(animated: true)
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func deletePressed(_ sender: Any) {
        if transaction.type == .income {
            userData.user.balance -= Double(userData.transactions[thisRow!].total!)
        } else {
            userData.user.balance += Double(userData.transactions[thisRow!].total!)
        }
        
        userData.transactions.remove(at: thisRow!)
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "load"), object: nil)
        self.navigationController?.popViewController(animated: true)
        self.navigationController?.popViewController(animated: true)
    }
    func updateUserBalance(num: Double, type: TransactionType) {
        
        if type == .income {
            userData.user.balance = userData.user.balance + num
        } else if type == .outcome {
            userData.user.balance = userData.user.balance - num
        }
    }
    
    func loadDefaultValue() {
        let userTransaction = userData.transactions
        descriptionInput.text = userTransaction[thisRow!].description
        totalInput.text = String(userTransaction[thisRow!].total!)
        print(userTransaction[thisRow!].type == .income, userTransaction[thisRow!].type == .outcome)
        if userTransaction[thisRow!].type == .income {
           loadViewStyle()
            transaction.type = .income
            incomeButton.radiusBorder(borderWidth: 4, borderColor: #colorLiteral(red: 0.3137254902, green: 0.4117647059, blue: 0.7215686275, alpha: 1))
        } else if userTransaction[thisRow!].type == .outcome {
            loadViewStyle()
            transaction.type = .outcome
            outcomeButton.radiusBorder(borderWidth: 4, borderColor: #colorLiteral(red: 0.3137254902, green: 0.4117647059, blue: 0.7215686275, alpha: 1))
        }
    }
    
    func loadViewStyle() {
        deleteButton.layer.borderWidth = 2
        deleteButton.layer.borderColor = #colorLiteral(red: 0.9215686275, green: 0.3411764706, blue: 0.3411764706, alpha: 1)
        
        incomeButton.centerImageAndButton(CGFloat(10), imageOnTop: true)
        incomeButton.radiusBorder(borderWidth: 2, borderColor: UIColor.white.cgColor)
        outcomeButton.centerImageAndButton(CGFloat(5), imageOnTop: true)
        outcomeButton.radiusBorder(borderWidth: 2, borderColor: UIColor.white.cgColor)
    }

}
