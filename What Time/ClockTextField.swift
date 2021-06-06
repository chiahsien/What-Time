//
//  ClockTextField.swift
//  What Time
//
//  Created by Nelson on 2021/6/6.
//

import UIKit

protocol ClockTextFieldDelegate: AnyObject {
    func textFieldWillDeleteBackward(_ textField: ClockTextField)
}

final class ClockTextField: UITextField {
    weak var deleteDelegate: ClockTextFieldDelegate?

    override func deleteBackward() {
        deleteDelegate?.textFieldWillDeleteBackward(self)
        super.deleteBackward()
    }
}
