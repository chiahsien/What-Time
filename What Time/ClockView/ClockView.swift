//
//  ClockView.swift
//  What Time
//
//  Created by Nelson on 2021/5/23.
//

import UIKit

class ClockView: UIView {
    var hoursData: [String] {
        set {
            hoursLayer.data = newValue
        }
        get {
            return hoursLayer.data
        }
    }

    var hoursColor: UIColor {
        set {
            hoursLayer.color = newValue
        }
        get {
            return hoursLayer.color
        }
    }

    var hoursFont: UIFont {
        set {
            hoursLayer.font = newValue
        }
        get {
            return hoursLayer.font
        }
    }

    var hourHandColor: UIColor {
        set {
            hourHandLayer.color = newValue
        }
        get {
            return hourHandLayer.color
        }
    }

    var minutesData: [String] {
        set {
            minutesLayer.data = newValue
        }
        get {
            return minutesLayer.data
        }
    }

    var minutesColor: UIColor {
        set {
            minutesLayer.color = newValue
        }
        get {
            return minutesLayer.color
        }
    }

    var minutesFont: UIFont {
        set {
            minutesLayer.font = newValue
        }
        get {
            return minutesLayer.font
        }
    }

    var minuteHandColor: UIColor {
        set {
            minuteHandLayer.color = newValue
        }
        get {
            return minuteHandLayer.color
        }
    }

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

    private var currentHour: Int = 0
    private var currentMinute: Int = 0

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    convenience init() {
        self.init(frame: .zero)
    }

    override func draw(_ rect: CGRect) {
        setupClockView()
        setupTicksLayer()
        setupHoursLayer()
        setupMinutesLayer()
        setupHandLayers()
    }

    func generateRandomTime() {
        let hour = Int.random(in: 1...12)
        let minute = Int.random(in: 0...11) * 5
        let minutesAngle: Degrees = (Degrees(minute) * 360 / 60)
        let hourAngle: Degrees = (Degrees(hour) * 360 / 12) + minutesAngle / 12

        var transform = CATransform3DIdentity
        transform = CATransform3DRotate(transform, minutesAngle.inRadians, 0, 0, 1)
        minuteHandLayer.transform = transform

        transform = CATransform3DIdentity
        transform = CATransform3DRotate(transform, hourAngle.inRadians, 0, 0, 1)
        hourHandLayer.transform = transform

        currentHour = hour
        currentMinute = minute
    }

    func isTime(hours h: Int, minutes m: Int) -> Bool {
        return currentHour == h && currentMinute == m
    }
}

private extension ClockView {
    func commonInit() {
        layer.borderColor = UIColor.gray.cgColor
        layer.borderWidth = 2
        layer.addSublayer(ticksLayer)
        layer.addSublayer(hoursLayer)
        layer.addSublayer(minutesLayer)
        layer.addSublayer(minuteHandLayer)
        layer.addSublayer(hourHandLayer)
    }

    func setupClockView() {
        let radius = bounds.width / 2
        layer.cornerRadius = radius
    }

    func setupTicksLayer() {
        ticksLayer.frame = bounds.insetBy(dx: 15, dy: 15)
        ticksLayer.setNeedsDisplay()
    }

    func setupHoursLayer() {
        hoursLayer.frame = bounds.insetBy(dx: 50, dy: 50)
        hoursLayer.setNeedsDisplay()
    }

    func setupMinutesLayer() {
        minutesLayer.frame = bounds.insetBy(dx: 10, dy: 10)
        minutesLayer.setNeedsDisplay()
    }

    func setupHandLayers() {
        let frame = bounds.insetBy(dx: 50, dy: 50)
        minuteHandLayer.frame = frame
        minuteHandLayer.setNeedsDisplay()

        hourHandLayer.frame = frame
        hourHandLayer.setNeedsDisplay()
    }
}
