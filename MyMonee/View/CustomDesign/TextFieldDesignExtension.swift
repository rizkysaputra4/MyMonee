//
//  TextFieldDesignExtension.swift
//  MyMonee
//
//  Created by Rizky Saputra on 19/05/21.
//

import UIKit

extension UITextField {
    func numberOnly() {
        return self.text = self.text?.filter("1234567890".contains)
    }
}
