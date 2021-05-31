//
//  Loading.swift
//  MyMonee
//
//  Created by Rizky Saputra on 21/05/21.
//

import UIKit

let child = SpinnerViewController()

extension UIViewController: ToastDelegate {
    
    func displayToast(message: String) {
        Toast.show(message: message, controller: self)
    }
    
    func startLoading() {
        self.tabBarController?.tabBar.isHidden = true
        addChild(child)
        child.view.frame = view.frame
        view.addSubview(child.view)
        child.didMove(toParent: self)
    }
    
    func stopLoading() {
        child.willMove(toParent: nil)
        child.view.removeFromSuperview()
        child.removeFromParent()
        self.tabBarController?.tabBar.isHidden = false
      
    }
}
