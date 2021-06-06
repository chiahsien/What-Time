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
    var bottomBorderColor: UIColor? {
        set {
            bottomBorder.backgroundColor = newValue
        }
        get {
            return bottomBorder.backgroundColor
        }
    }

    private var bottomBorder: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    override func deleteBackward() {
        deleteDelegate?.textFieldWillDeleteBackward(self)
        super.deleteBackward()
    }
}

private extension ClockTextField {
    func commonInit() {
        addSubview(bottomBorder)
        bottomBorder.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            bottomBorder.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 1),
            bottomBorder.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 1),
            bottomBorder.bottomAnchor.constraint(equalTo: bottomAnchor),
            bottomBorder.heightAnchor.constraint(equalToConstant: 1)
        ])
    }
}
