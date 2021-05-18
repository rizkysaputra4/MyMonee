//
//  EditDreamViewController.swift
//  MyMonee
//
//  Created by Rizky Saputra on 16/05/21.
//

import UIKit

class EditDreamViewController: UIViewController {

    @IBOutlet weak var deleteBtn: UIButton!
    @IBOutlet weak var editBtn: UIButton!
    @IBOutlet weak var dreamDescription: UITextField!
    @IBOutlet weak var targetTotal: UITextField!
    @IBOutlet weak var updateProgressSlider: UISlider!
    @IBOutlet weak var updateProgressLabel: UILabel!
    
    var thisRow: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dreamDescription.addTarget(self, action: #selector(self.didChange(_:)), for: .editingChanged)
        targetTotal.addTarget(self, action: #selector(self.didChange(_:)), for: .editingChanged)
        
        loadDefaultValue()
        loadStyle()
    }

    @IBAction func backPressed(_ sender: Any) {
        navigationController?.popViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func didChange(_ textField: UITextField) {
        targetTotal.numberOnly()
        isFilled()
    }
    
    func isFilled() {
        let isDescriptionEmty = dreamDescription.text?.isEmpty ?? true
        let isTotalEmpty = targetTotal.text?.isEmpty ?? true

        if  isDescriptionEmty || isTotalEmpty {
            editBtn.layer.backgroundColor = UIColor.init(named: "disabled")?.cgColor
        } else {
            editBtn.layer.backgroundColor = UIColor.init(named: "main")?.cgColor
            editBtn.isEnabled = true
        }
        
    }
    @IBAction func editPressed(_ sender: Any) {
        let dream = Dream(description: dreamDescription.text!, target: userData.dreams[thisRow!].target, saved: Double(updateProgressSlider.value))
        userData.dreams[thisRow!] = dream
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "dream updated"), object: nil)
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "updateDetail"), object: nil)
        
        dismiss()
    }
    
    @IBAction func deletePressed(_ sender: Any) {
        userData.dreams.remove(at: thisRow!)
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "dream updated"), object: nil)
        dismiss()
    }
    
    func dismiss() {
        self.navigationController?.popToRootViewController(animated: true)
        
    }
    
    @IBAction func updateProgress(_ sender: Any) {
        updateProgressLabel.text = toStringCurrency(number: Double(updateProgressSlider.value))
    }
    
    func loadDefaultValue() {
        dreamDescription.text = userData.dreams[thisRow!].description
        targetTotal.text = String(userData.dreams[thisRow!].target).filter("1234567890".contains)
        
        
        updateProgressSlider.minimumValue = 0
        updateProgressSlider.maximumValue = Float(userData.dreams[thisRow!].target)
        updateProgressSlider.value = Float(userData.dreams[thisRow!].saved)
        updateProgressLabel.text = toStringCurrency(number: Double(updateProgressSlider.value))
    }
    
    func loadStyle() {
        deleteBtn.setTitleColor(UIColor.init(named: "danger"), for: .normal)
        deleteBtn.layer.borderWidth = 2
        deleteBtn.layer.borderColor = UIColor.init(named: "danger")?.cgColor
    }
    
}
