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
            self.clockView.updateTo(hour: 7, minute: 23)
            self.hourTextField.becomeFirstResponder()
        }
    }
}

private extension ClockViewController {
    @objc
    func hourTextFieldDidReturn() {

    }

    @objc
    func minuteTextFieldDidReturn() {

    }
}
