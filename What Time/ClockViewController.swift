//
//  ClockViewController.swift
//  What Time
//
//  Created by Nelson on 2021/5/21.
//

import UIKit

final class ClockViewController: UIViewController {

    @IBOutlet private weak var clockView: UIView!
    @IBOutlet private weak var hourTextField: UITextField!
    @IBOutlet private weak var minuteTextField: UITextField!

    private let ticksLayer: CAReplicatorLayer = {
        let layer = CAReplicatorLayer()
        layer.instanceCount = 12
        layer.instanceTransform = CATransform3DMakeRotation(30 * .pi / 180, 0, 0, 1)
        return layer
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        clockView.layer.borderColor = UIColor.gray.cgColor
        clockView.layer.borderWidth = 2
        clockView.layer.addSublayer(ticksLayer)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupClockView()
        setupTicksLayer()
    }
}

private extension ClockViewController {
    private func setupClockView() {
        let radius = clockView.bounds.width / 2
        clockView.layer.cornerRadius = radius
    }

    private func setupTicksLayer() {
        ticksLayer.frame = clockView.bounds
        ticksLayer.sublayers?.removeAll()

        let tick = CALayer()
        tick.frame = CGRect(x: ticksLayer.bounds.midX - 1, y: 15, width: 2, height: 15)
        tick.backgroundColor = UIColor.gray.cgColor
        ticksLayer.addSublayer(tick)
    }
}
