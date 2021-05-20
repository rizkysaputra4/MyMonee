//
//  AddTransactionViewController.swift
//  MyMonee
//
//  Created by Rizky Saputra on 15/05/21.
//

import UIKit

class AddTransactionViewController: UIViewController, UITextViewDelegate {
    
    @IBOutlet weak var incomeButton: UIButton!
    @IBOutlet weak var outcomeButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var descriptionInput: UITextField!
    @IBOutlet weak var totalInput: UITextField!
    
    var transaction: Transaction = Transaction()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        normalStyle()
        
        saveButton.isEnabled = false
        isFilled()
        descriptionInput.addTarget(self, action: #selector(self.didChange(_:)), for: .editingChanged)
        totalInput.addTarget(self, action: #selector(self.didChange(_:)), for: .editingChanged)
        
    }

    @IBAction func pressBack(_ sender: Any) {
        dismiss()
    }
    
    func isFilled() {
        let isDescriptionEmty = descriptionInput.text?.isEmpty ?? true
        let isTotalEmpty = totalInput.text?.isEmpty ?? true
        let isTransactionTypeEmpty = transaction.type == nil
       
        if  isDescriptionEmty || isTotalEmpty || isTransactionTypeEmpty {
            saveButton.isEnabled = false
            saveButton.layer.backgroundColor = UIColor(named: "disabled")?.cgColor
        } else {
            saveButton.layer.backgroundColor = UIColor(named: "main")?.cgColor
            saveButton.isEnabled = true
        }
        
    }
    
    @objc func didChange(_ textField: UITextField) {
        totalInput.numberOnly()
        isFilled()
    }
    
   @objc func incomeBtnPressed(_ sender: Any) {
        transaction.type = .income
    normalStyle()
    incomeButton.radiusBorder(borderWidth: 4, borderColor: UIColor.init(named: "main")?.cgColor ?? #colorLiteral(red: 0.3137254902, green: 0.4117647059, blue: 0.7215686275, alpha: 1))
    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "dream updated"), object: nil)
        isFilled()
    }
    
    @objc func outcomeBtnPressed(_ sender: Any) {
        transaction.type = .outcome
        normalStyle()
        outcomeButton.radiusBorder(borderWidth: 4, borderColor: UIColor.init(named: "main")?.cgColor ?? #colorLiteral(red: 0.3137254902, green: 0.4117647059, blue: 0.7215686275, alpha: 1))
        isFilled()
    }
    
    func normalStyle() {
        incomeButton.centerImageAndButton(CGFloat(10), imageOnTop: true)
        incomeButton.radiusBorder(borderWidth: 2, borderColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))
        incomeButton.dropShadow()
        outcomeButton.centerImageAndButton(CGFloat(10), imageOnTop: true)
        outcomeButton.radiusBorder(borderWidth: 2, borderColor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0))
        outcomeButton.dropShadow()
    }
    
    @IBAction func savePressed(_ sender: Any) {
        transaction.description = descriptionInput.text
        transaction.total = Double(totalInput.text!) ?? 0
        transaction.date = Date()
        transaction.uuid = randomString(length: 8)
        userData.transactions.append(transaction)
        updateUserBalance(num: transaction.total!, type: transaction.type!)
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "load"), object: nil)
        
        encodeAndSaveToLocal(data: userData)
        dismiss()
    }
    
    func dismiss() {
        navigationController?.popViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
    }
    
    func updateUserBalance(num: Double, type: TransactionType) {
        userData.updateBalance(num: num, type: type)
        
    }
}
