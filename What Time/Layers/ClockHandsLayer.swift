//
//  ClockHandsLayer.swift
//  What Time
//
//  Created by Nelson on 2021/5/22.
//

import UIKit

///
/// Most of the codes are from
/// https://github.com/HarshilShah/Watchface
///
final class ClockHandsLayer: CAShapeLayer {

    enum HandType {
        case minute, hour

        var lengthRatio: CGFloat {
            switch self {
            case .minute:
                return 1
            case .hour:
                return 0.7
            }
        }
    }

    var type: HandType = .hour {
        didSet {
            setNeedsDisplay()
        }
    }

    var color: UIColor = .white {
        didSet {
            strokeColor = color.cgColor
            setNeedsDisplay()
        }
    }

    override init() {
        super.init()
        setup()
    }

    override init(layer: Any) {
        super.init(layer: layer)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func display() {
        strokeColor = color.cgColor
        fillColor = color.cgColor

        let newPath = getPath().cgPath
        path = newPath
    }

    private func setup() {
        lineCap = .round
        lineJoin = .round
    }

    private func getPath() -> UIBezierPath {
        let center = CGPoint(x: bounds.midX, y: bounds.midY)
        let path = UIBezierPath(arcCenter: center, radius: 4, startAngle: Degrees(0).inRadians, endAngle: Degrees(180).inRadians, clockwise: true)

        path.addLine(to: CGPoint(x: bounds.midX, y: (bounds.midY - bounds.midY * type.lengthRatio)))
        path.close()
        return path
    }
}
