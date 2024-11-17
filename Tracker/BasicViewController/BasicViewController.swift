//
//  BasicViewController.swift
//  Tracker
//
//  Created by Varvara Kiseleva on 17.11.2024.
//

import UIKit


class BasicViewController: UIViewController {
    private var constraints = [NSLayoutConstraint]()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNeedsStatusBarAppearanceUpdate()
    }
}
