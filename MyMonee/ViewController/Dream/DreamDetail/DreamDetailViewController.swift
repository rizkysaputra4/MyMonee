//
//  DreamDetailViewController.swift
//  MyMonee
//
//  Created by Rizky Saputra on 15/05/21.
//

import UIKit

class DreamDetailViewController: UIViewController {

    @IBOutlet weak var heartView: UIView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var progressView: UIView!
    @IBOutlet weak var progressViewBar: UIProgressView!
    @IBOutlet weak var dreamArchieved: UIButton!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var progressPercentage: UILabel!
    @IBOutlet weak var progressBarLabel: UILabel!
    
    var thisRow: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(viewDidLoad), name: NSNotification.Name(rawValue: "updateDetail"), object: nil)
        
       loadViewStyle()
        archieveBtnHandler()
    
    }

    @IBAction func backPressed(_ sender: Any) {
        dismiss()
    }
    
    func dismiss() {
        navigationController?.popViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func editPressed(_ sender: Any) {
        let editDreamPage = EditDreamViewController(nibName: "EditDreamViewController", bundle: nil)
        editDreamPage.thisRow = self.thisRow
        self.navigationController?.pushViewController(editDreamPage, animated: true)
    }
    
    func archieveBtnHandler() {
        if userData.dreams[thisRow!].getDreamProgress() >= 1 {
            dreamArchieved.layer.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            dreamArchieved.isEnabled = false
        } else {
            dreamArchieved.layer.backgroundColor = #colorLiteral(red: 0.3137254902, green: 0.4117647059, blue: 0.7215686275, alpha: 1)
        }
    }
    
    @IBAction func archieveBtnPressed(_ sender: Any) {
        userData.dreams[thisRow!].saved = userData.dreams[thisRow!].target
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "dream updated"), object: nil)
//        progressArchieved()
        viewDidLoad()
        archieveBtnHandler()
    }
    
    func progressArchieved() {
        progressViewBar.progress = 1
        progressPercentage.text = "100.0"
        progressBarLabel.text = userData.dreams[thisRow!].currencyToString()
    }
    
    func loadViewStyle() {
        let thisDream = userData.dreams[thisRow!]
        descriptionLabel.text = thisDream.description
        price.text = thisDream.getStringTarget()
        
        let progressPercent = String(thisDream.getDreamProgress() * 100)
        progressPercentage.text = "\(progressPercent) %"
        
        progressViewBar.progress = Float(thisDream.getDreamProgress())
        progressBarLabel.text = thisDream.currencyToString()
        
        heartView.layer.borderWidth = 1
        heartView.layer.borderColor = #colorLiteral(red: 0.1921568662, green: 0.007843137719, blue: 0.09019608051, alpha: 1)
        heartView.layer.cornerRadius = 4
        
        progressView.layer.borderWidth = 1
        progressView.layer.borderColor = #colorLiteral(red: 0.3830927014, green: 0.3831023574, blue: 0.3830972314, alpha: 1)
        progressView.layer.cornerRadius = 8
        
        backButton.layer.borderWidth = 2
        backButton.layer.borderColor = #colorLiteral(red: 0.3137254902, green: 0.4117647059, blue: 0.7215686275, alpha: 1)
    }
}
