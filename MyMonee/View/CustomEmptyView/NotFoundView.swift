//
//  NotFoundView.swift
//  MyMonee
//
//  Created by Rizky Saputra on 18/05/21.
//

import UIKit

protocol Navigations {
    func toAddNewPage()
}

class NotFoundView: UIView {

    @IBOutlet weak var textViewArea: UITextView!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet var contentView: UIView!
    
    var type: String!
    var navigationDelegate: Navigations!
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
            initSubviews()
        }

    override init(frame: CGRect) {
        super.init(frame: frame)
        initSubviews()
    }

    func initSubviews() {
       
        let nib = UINib(nibName: "NotFoundView", bundle: nil)
        nib.instantiate(withOwner: self, options: nil)
        contentView.frame = bounds
        addSubview(contentView)

        loadData()
    }
    
    @IBAction func addButtonPressed(_ sender: Any) {
        navigationDelegate.toAddNewPage()
    }
    
    func loadData() {
        
        addButton.backgroundColor = UIColor(named: "main")
        addButton.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
        addButton.layer.cornerRadius = 20
        
        contentView.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    }
}
