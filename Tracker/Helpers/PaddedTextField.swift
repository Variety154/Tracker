//
//  PaddedTextField.swift
//  Tracker
//
//  Created by Varvara Kiseleva on 17.11.2024.
//

import UIKit

final class PaddedTextField: UITextField {
    
    var textPadding = UIEdgeInsets(top: 0, left: Insets.leading, bottom: 0, right: 0)
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: textPadding)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: textPadding)
    }
}
