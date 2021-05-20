//
//  ButtonDesignExtension.swift
//  MyMonee
//
//  Created by Rizky Saputra on 19/05/21.
//

import UIKit

extension UIButton {

    func centerImageAndButton(_ gap: CGFloat, imageOnTop: Bool) {

      guard let imageView = self.currentImage,
      let titleLabel = self.titleLabel?.text else { return }

      let sign: CGFloat = imageOnTop ? 1 : -1
        self.titleEdgeInsets = UIEdgeInsets.init(top: (imageView.size.height + gap) * sign, left: -imageView.size.width, bottom: 0, right: 0)

        let titleSize = titleLabel.size(withAttributes: [NSAttributedString.Key.font: self.titleLabel!.font!])
        self.imageEdgeInsets = UIEdgeInsets.init( top: -(titleSize.height + gap) * sign, left: 0, bottom: 0, right: -titleSize.width)
    }
    
    func radiusBorder(borderWidth: Int, borderColor: CGColor) {
        self.layer.cornerRadius = 5
        self.layer.borderWidth = CGFloat(borderWidth)
        self.layer.borderColor = borderColor
    }
    
    func dropShadow(scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.3
        layer.shadowOffset = CGSize(width: 0, height: 1)
        layer.shadowRadius = 2

        layer.shadowPath = UIBezierPath(rect: bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
      }
    
    func disabled() {
        self.setImage(UIImage.init(named: "checklist_disabled"), for: .normal)
        self.isEnabled = false
    }
    
    func enabled() {
        self.isEnabled = true
        self.setImage(UIImage.init(named: "checklist_enabled"), for: .normal)
    }
}
