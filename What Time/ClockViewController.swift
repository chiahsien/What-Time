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

    private let ticksLayer = ClockTicksLayer()
    private let hoursLayer: ClockNumeralsLayer = {
        let layer = ClockNumeralsLayer()
        layer.data = ["12", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11"]
        layer.color = .black
        layer.font = UIFont.systemFont(ofSize: 18, weight: .heavy)
        return layer
    }()
    private let minutesLayer: ClockNumeralsLayer = {
        let layer = ClockNumeralsLayer()
        layer.data = ["00", "05", "10", "15", "20", "25", "30", "35", "40", "45", "50", "55"]
        layer.color = .black
        layer.font = UIFont.systemFont(ofSize: 14, weight: .light)
        return layer
    }()
    private let hourHandLayer: ClockHandsLayer = {
        let layer = ClockHandsLayer()
        layer.type = .hour
        layer.color = .red
        return layer
    }()
    private let minuteHandLayer: ClockHandsLayer = {
        let layer = ClockHandsLayer()
        layer.type = .minute
        layer.color = .darkGray
        return layer
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        clockView.layer.borderColor = UIColor.gray.cgColor
        clockView.layer.borderWidth = 2
        clockView.layer.addSublayer(ticksLayer)
        clockView.layer.addSublayer(hoursLayer)
        clockView.layer.addSublayer(minutesLayer)
        clockView.layer.addSublayer(minuteHandLayer)
        clockView.layer.addSublayer(hourHandLayer)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupClockView()
        setupTicksLayer()
        setupHoursLayer()
        setupMinutesLayer()
        setupHandLayers()

        updateTo(hour: 9, minute: 25)
    }
}

private extension ClockViewController {
    func setupClockView() {
        let radius = clockView.bounds.width / 2
        clockView.layer.cornerRadius = radius
    }

    func setupTicksLayer() {
        ticksLayer.frame = clockView.bounds.insetBy(dx: 15, dy: 15)
        ticksLayer.setNeedsDisplay()
    }

    func setupHoursLayer() {
        hoursLayer.frame = clockView.bounds.insetBy(dx: 50, dy: 50)
        hoursLayer.setNeedsDisplay()
    }

    func setupMinutesLayer() {
        minutesLayer.frame = clockView.bounds.insetBy(dx: 10, dy: 10)
        minutesLayer.setNeedsDisplay()
    }

    func setupHandLayers() {
        minuteHandLayer.frame = clockView.bounds.insetBy(dx: 50, dy: 50)
        minuteHandLayer.setNeedsDisplay()

        hourHandLayer.frame = clockView.bounds.insetBy(dx: 50, dy: 50)
        hourHandLayer.setNeedsDisplay()
    }

    func updateTo(hour h: Int, minute m: Int) {
        let minutesAngle: Degrees = (Degrees(m) * 360 / 60)
        let hourAngle: Degrees = (Degrees(h) * 360 / 12) + minutesAngle/12

        minuteHandLayer.setAffineTransform(CGAffineTransform(rotationAngle: minutesAngle.inRadians))
        hourHandLayer.setAffineTransform(CGAffineTransform(rotationAngle: hourAngle.inRadians))
    }
}
