//
//  AddTransactionViewController.swift
//  MyMonee
//
//  Created by Rizky Saputra on 15/05/21.
//

import UIKit

class AddTransactionViewController: UIViewController {
    
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
            saveButton.layer.backgroundColor = #colorLiteral(red: 0.5148796439, green: 0.5535522103, blue: 0.5920764804, alpha: 1)
        } else {
            saveButton.layer.backgroundColor = #colorLiteral(red: 0.3137254902, green: 0.4117647059, blue: 0.7215686275, alpha: 1)
            saveButton.isEnabled = true
        }
        
    }
    
    @objc func didChange(_ textField: UITextField) {
             isFilled()
    }
    
   @objc func incomeBtnPressed(_ sender: Any) {
        transaction.type = .income
    normalStyle()
    incomeButton.radiusBorder(borderWidth: 4, borderColor: UIColor.blue.cgColor)
        isFilled()
    }
    
    @objc func outcomeBtnPressed(_ sender: Any) {
        transaction.type = .outcome
        normalStyle()
        outcomeButton.radiusBorder(borderWidth: 4, borderColor: UIColor.blue.cgColor)
        isFilled()
    }
    
    func normalStyle() {
        incomeButton.centerImageAndButton(CGFloat(10), imageOnTop: true)
        incomeButton.radiusBorder(borderWidth: 2, borderColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))
        outcomeButton.centerImageAndButton(CGFloat(5), imageOnTop: true)
        outcomeButton.radiusBorder(borderWidth: 2, borderColor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0))
    }
    
    @IBAction func savePressed(_ sender: Any) {
        transaction.description = descriptionInput.text
        transaction.total = Double(totalInput.text!) ?? 0
       
        userData.transactions.append(transaction)
        updateUserBalance(num: transaction.total!, type: transaction.type!)
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "load"), object: nil)
        dismiss()
    }
    
    func dismiss() {
        navigationController?.popViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
    }
    
    func updateUserBalance(num: Double, type: TransactionType) {
        
        if type == .income {
            userData.user.balance += num
            print(userData.user.balance)
        } else if type == .outcome {
            userData.user.balance -= num
        }
    }
}

extension UIButton {

    func centerImageAndButton(_ gap: CGFloat, imageOnTop: Bool) {

      guard let imageView = self.currentImage,
      let titleLabel = self.titleLabel?.text else { return }

      let sign: CGFloat = imageOnTop ? 1 : -1
        self.titleEdgeInsets = UIEdgeInsets.init(top: (imageView.size.height + gap) * sign, left: -imageView.size.width, bottom: 0, right: 0)

        let titleSize = titleLabel.size(withAttributes: [NSAttributedString.Key.font: self.titleLabel!.font!])
        self.imageEdgeInsets = UIEdgeInsets.init( top: -(titleSize.height + gap) * sign, left: 0, bottom: 0, right: -titleSize.width)
    }
    
    func radiusBorder(borderWidth: Int, borderColor: CGColor) {
        self.layer.cornerRadius = 5
        self.layer.borderWidth = CGFloat(borderWidth)
        self.layer.borderColor = borderColor
    }
}
