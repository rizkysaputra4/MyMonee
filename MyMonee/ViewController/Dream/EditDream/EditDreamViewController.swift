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
             isFilled()
    }
    
    func isFilled() {
        let isDescriptionEmty = dreamDescription.text?.isEmpty ?? true
        let isTotalEmpty = targetTotal.text?.isEmpty ?? true

        if  isDescriptionEmty || isTotalEmpty {
            editBtn.layer.backgroundColor = #colorLiteral(red: 0.5148796439, green: 0.5535522103, blue: 0.5920764804, alpha: 1)
        } else {
            editBtn.layer.backgroundColor = #colorLiteral(red: 0.3137254902, green: 0.4117647059, blue: 0.7215686275, alpha: 1)
            editBtn.isEnabled = true
        }
        
    }
    @IBAction func editPressed(_ sender: Any) {
        let dream = Dream(description: dreamDescription.text!, target: Double(targetTotal.text!) ?? 0, saved: userData.dreams[thisRow!].saved)
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
        navigationController?.popViewController(animated: true)
        self.navigationController?.popViewController(animated: true)
        
    }
    
    func loadDefaultValue() {
        dreamDescription.text = userData.dreams[thisRow!].description
        targetTotal.text = String(userData.dreams[thisRow!].target)
    }
    
    func loadStyle() {
        deleteBtn.layer.borderWidth = 2
        deleteBtn.layer.borderColor = #colorLiteral(red: 0.3137254902, green: 0.4117647059, blue: 0.7215686275, alpha: 1)
    }
    
}
