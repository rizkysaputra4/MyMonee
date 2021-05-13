//
//  TransactionTableViewCell.swift
//  MyMonee
//
//  Created by Rizky Saputra on 13/05/21.
//

import UIKit

class TransactionTableViewCell: UITableViewCell {

    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var arrowImg: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var total: UILabel!
    
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var arrowBackground: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
