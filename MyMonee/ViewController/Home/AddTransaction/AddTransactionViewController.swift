//
//  AddTransactionViewController.swift
//  MyMonee
//
//  Created by Rizky Saputra on 15/05/21.
//

import UIKit

class AddTransactionViewController: UIViewController {
    
    @IBOutlet weak var incomeButton: UIButton!
    @IBOutlet weak var outcomeButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        incomeButton.centerImageAndButton(CGFloat(10), imageOnTop: true)
        incomeButton.radiusBorder()
        outcomeButton.centerImageAndButton(CGFloat(5), imageOnTop: true)
        outcomeButton.radiusBorder()
//        incomeView.layer.borderWidth = 10
//        incomeView.layer.borderColor = UIColor.red.cgColor
//        incomeView.layer.shadowOffset = .zero
//        incomeView.layer.shadowColor = UIColor.black.cgColor
//        incomeView.layer.shadowRadius = 10
//        incomeView.layer.shadowOpacity = 1
//        incomeView.layer.shadowPath = UIBezierPath(rect: incomeView.bounds).cgPath
        // Do any additional setup after loading the view.
    }

    @IBAction func pressBack(_ sender: Any) {
        navigationController?.popViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
    }
}

extension UIButton {

    func centerImageAndButton(_ gap: CGFloat, imageOnTop: Bool) {

      guard let imageView = self.currentImage,
      let titleLabel = self.titleLabel?.text else { return }

      let sign: CGFloat = imageOnTop ? 1 : -1
        self.titleEdgeInsets = UIEdgeInsets.init(top: (imageView.size.height + gap) * sign, left: -imageView.size.width, bottom: 0, right: 0)

        let titleSize = titleLabel.size(withAttributes: [NSAttributedString.Key.font: self.titleLabel!.font!])
        self.imageEdgeInsets = UIEdgeInsets.init( top: -(titleSize.height + gap) * sign, left: 0, bottom: 0, right: -titleSize.width)
    }
    
    func radiusBorder() {
        self.layer.cornerRadius = 5
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.black.cgColor
    }
}
