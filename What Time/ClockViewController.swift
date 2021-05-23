//
//  ClockViewController.swift
//  What Time
//
//  Created by Nelson on 2021/5/21.
//

import UIKit

final class ClockViewController: UIViewController {

    @IBOutlet private weak var clockView: ClockView!
    @IBOutlet private weak var hourTextField: UITextField!
    @IBOutlet private weak var minuteTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        hourTextField.addDoneToolbar("下一個", onDone: (target: self, action: #selector(hourTextFieldDidReturn)))
        minuteTextField.addDoneToolbar("確定", onDone: (target: self, action: #selector(minuteTextFieldDidReturn)))

        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.1) {
            self.clockView.generateRandomTime()
            self.hourTextField.becomeFirstResponder()
        }
    }
}

extension ClockViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text, let range = Range(range, in: text) else { return false }

        let newText = text.replacingCharacters(in: range, with: string)
        textField.text = newText

        if newText.count == 2 {
            if textField.isEqual(hourTextField) {
                minuteTextField.becomeFirstResponder()
            } else {
                minuteTextFieldDidReturn()
            }
        }
        return false
    }
}

private extension ClockViewController {
    @objc
    func hourTextFieldDidReturn() {
        minuteTextField.becomeFirstResponder()
    }

    @objc
    func minuteTextFieldDidReturn() {
        let hours = Int(hourTextField.text!) ?? 1
        let minutes = Int(minuteTextField.text!) ?? 0
        if (clockView.isTime(hours: hours, minutes: minutes)) {
            clockView.generateRandomTime()
            minuteTextField.text = nil
            hourTextField.text = nil
            hourTextField.becomeFirstResponder()
        } else {
            print("Bad")
        }
    }
}
