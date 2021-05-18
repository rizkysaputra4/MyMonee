//
//  DreamTableViewCell.swift
//  MyMonee
//
//  Created by Rizky Saputra on 15/05/21.
//

import UIKit

protocol CellDelegate: AnyObject {
    func toDetailPage(thisRow: Int)
}

class DreamTableViewCell: UITableViewCell {
    
    weak var cellDelegate: CellDelegate?
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var progress: UIProgressView!
    @IBOutlet weak var progressLabel: UILabel!
    @IBOutlet weak var cellView: UIView!
    //    var userDataReceived: UserData?
    var currentRow: Int?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.buttonPressed))
        cellView.isUserInteractionEnabled = true
        cellView.addGestureRecognizer(tap)
        self.selectionStyle = .none
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    @objc func buttonPressed() {
        cellDelegate?.toDetailPage(thisRow: currentRow!)
    }
}
