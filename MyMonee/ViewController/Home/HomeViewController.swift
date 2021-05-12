//
//  HomeViewController.swift
//  MyMonee
//
//  Created by Rizky Saputra on 12/05/21.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet var mainView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var saldoView: UIView!
    @IBOutlet weak var balanceLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.isNavigationBarHidden = true
        nameLabel.text = user.name
        balanceLabel.text = "Rp. \(user.currencyFormat())"
        
        saldoView.layer.cornerRadius = 8
        
    }
    
}
