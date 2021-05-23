//
//  UITextField+Extension.swift
//  What Time
//
//  Created by Nelson on 2021/5/23.
//

import UIKit

extension UITextField {
    /// This is from https://stackoverflow.com/a/45771094
    func addDoneToolbar(_ title: String, onDone: (target: Any, action: Selector)) {
        let toolbar: UIToolbar = UIToolbar()
        toolbar.barStyle = .default
        toolbar.items = [
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil),
            UIBarButtonItem(title: title, style: .done, target: onDone.target, action: onDone.action)
        ]
        toolbar.sizeToFit()

        self.inputAccessoryView = toolbar
    }
}
