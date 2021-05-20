//
//  DreamTableViewCell.swift
//  MyMonee
//
//  Created by Rizky Saputra on 15/05/21.
//

import UIKit

protocol CellDelegate: AnyObject {
    func toDetailPage(thisRow: Int)
    func deleteDream(thisRow: Int)
    func archievedDream(thisRow: Int)
}

class DreamTableViewCell: UITableViewCell {
    
    weak var cellDelegate: CellDelegate?
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var progress: UIProgressView!
    @IBOutlet weak var progressLabel: UILabel!
    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var archievedButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var detailBarView: UIView!
    
    var currentRow: Int?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.buttonPressed))
        
        detailBarView.isUserInteractionEnabled = true
        detailBarView.addGestureRecognizer(tap)
        self.selectionStyle = .none
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        enabledOrDisableBtn()
    }
    
    func enabledOrDisableBtn() {
        if userData.user.balance < userData.dreams[self.currentRow!].target {
            archievedButton.disabled()
        } else {
            archievedButton.enabled()
        }
    }
    
    @objc func buttonPressed() {
        cellDelegate?.toDetailPage(thisRow: currentRow!)
    }
    
    @IBAction func archievedBtnPressed(_ sender: Any) {
        cellDelegate?.archievedDream(thisRow: currentRow!)
    }
    
    @IBAction func deleteBtnPressed(_ sender: Any) {
        cellDelegate?.deleteDream(thisRow: currentRow!)
    }
    
}
