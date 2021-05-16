//
//  ProfileViewController.swift
//  MyMonee
//
//  Created by Rizky Saputra on 12/05/21.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var descriptionLabel: UITextView!
    @IBOutlet weak var editBtn: UIButton!
    @IBOutlet weak var editImgBtn: UIButton!
    @IBOutlet weak var editNameBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.isNavigationBarHidden = true
        loadAll()
        hiddenComponent()
    }
    
    func loadAll() {
        userName.text = userData.user.name
        descriptionLabel.text = "Bagus, pengeluaranmu lebih sedikit dari pada pemasukan."
    }
    
    @IBAction func editBtnPressed(_ sender: Any) {
        print(editBtn.titleLabel?.text == "Selesai")
        
        if editBtn.titleLabel?.text == "Selesai" {
            hiddenComponent()
            editBtn.setTitle("Edit", for: .normal)
        } else {
            showHiddenComponent()
            editBtn.setTitle("Selesai", for: .normal)
        }
        
    }
    
    func hiddenComponent() {
        editImgBtn.isHidden = true
        editNameBtn.isHidden = true
    }
    
    func showHiddenComponent() {
        editImgBtn.isHidden = false
        editNameBtn.isHidden = false
    }

}
