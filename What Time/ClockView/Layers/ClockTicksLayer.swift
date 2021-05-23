//
//  ClockTicksLayer.swift
//  What Time
//
//  Created by Nelson on 2021/5/22.
//

import UIKit

final class ClockTicksLayer: CAReplicatorLayer {
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

    override func draw(in ctx: CGContext) {
        sublayers?.removeAll()
        let tick = CALayer()
        tick.frame = CGRect(x: bounds.midX - 1, y: 15, width: 2, height: 15)
        tick.backgroundColor = UIColor.gray.cgColor
        addSublayer(tick)
    }

    private func setup() {
        instanceCount = 12
        instanceTransform = CATransform3DMakeRotation(30 * .pi / 180, 0, 0, 1)
    }
}
