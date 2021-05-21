//
//  Loading.swift
//  MyMonee
//
//  Created by Rizky Saputra on 21/05/21.
//

import UIKit

class SpinnerViewController: UIViewController {
    var spinner = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)

    override func loadView() {
        view = UIView()
        view.backgroundColor = UIColor(white: 0, alpha: 0.5)
        
        spinner.color = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.startAnimating()
        view.addSubview(spinner)

        spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
}
