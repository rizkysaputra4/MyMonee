//
//  AddDreamViewController.swift
//  MyMonee
//
//  Created by Rizky Saputra on 15/05/21.
//

import UIKit

class AddDreamViewController: UIViewController {

    @IBOutlet var mainView: UIView!
    
    @IBOutlet weak var targetTotal: UITextField!
    @IBOutlet weak var descriptionInput: UITextField!
    @IBOutlet weak var saveBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        isFilled()
        descriptionInput.addTarget(self, action: #selector(self.didChange(_:)), for: .editingChanged)
        targetTotal.addTarget(self, action: #selector(self.didChange(_:)), for: .editingChanged)
        
    }

    @IBAction func backPressed(_ sender: Any) {
        dismiss()
    }
    
    @objc func didChange(_ textField: UITextField) {
             isFilled()
    }
    
    func isFilled() {
        let isDescriptionEmty = descriptionInput.text?.isEmpty ?? true
        let isTotalEmpty = targetTotal.text?.isEmpty ?? true

        if  isDescriptionEmty || isTotalEmpty {
            saveBtn.layer.backgroundColor = #colorLiteral(red: 0.5148796439, green: 0.5535522103, blue: 0.5920764804, alpha: 1)
        } else {
            saveBtn.layer.backgroundColor = #colorLiteral(red: 0.3137254902, green: 0.4117647059, blue: 0.7215686275, alpha: 1)
            saveBtn.isEnabled = true
        }
        
    }
    
    @IBAction func saveBtnPressed(_ sender: Any) {
        let dream = Dream(description: descriptionInput.text!, target: Double(targetTotal.text!) ?? 0, saved: 0)
        userData.dreams.append(dream)
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "dream updated"), object: nil)
        dismiss()
    }
    
    func dismiss() {
        navigationController?.popViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
    }
    
}
