//
//  ClockViewController.swift
//  What Time
//
//  Created by Nelson on 2021/5/21.
//

import UIKit

final class ClockViewController: UIViewController {

    @IBOutlet var inputFields: [ClockTextField]!
    @IBOutlet private weak var clockView: ClockView!

    override func viewDidLoad() {
        super.viewDidLoad()

        for textField in inputFields {
            textField.deleteDelegate = self
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.clockView.generateRandomTime()
            self.inputFields[0].becomeFirstResponder()
        }
    }
}

extension ClockViewController: UITextFieldDelegate, ClockTextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text, let range = Range(range, in: text) else { return false }

        let newText = text.replacingCharacters(in: range, with: string)
        textField.text = newText
        if newText.count == 1 {
            if textField.tag < 3 {
                inputFields[textField.tag + 1].becomeFirstResponder()
            } else {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                    self.checkAnswer()
                }
            }
        }
        return false
    }

    func textFieldWillDeleteBackward(_ textField: ClockTextField) {
        if (textField.text?.count == 0 && textField.tag > 0) {
            inputFields[textField.tag - 1].becomeFirstResponder()
            inputFields[textField.tag - 1].deleteBackward()
        }
    }
}

private extension ClockViewController {
    func checkAnswer() {
        let hours1 = Int(inputFields[0].text!) ?? 0
        let hours2 = Int(inputFields[1].text!) ?? 0
        let minutes1 = Int(inputFields[2].text!) ?? 0
        let minutes2 = Int(inputFields[3].text!) ?? 0
        let hours = hours1 * 10 + hours2
        let minutes = minutes1 * 10 + minutes2
        if (clockView.isTime(hours: hours, minutes: minutes)) {
            clockView.generateRandomTime()
            inputFields[0].text = nil
            inputFields[1].text = nil
            inputFields[2].text = nil
            inputFields[3].text = nil
            inputFields[0].becomeFirstResponder()
        } else {
            print("Bad")
        }
    }
}
