//
//  NumeralsLayer.swift
//  What Time
//
//  Created by Nelson on 2021/5/22.
//

import UIKit

///
/// Most of the codes are from
/// https://github.com/HarshilShah/Watchface
///
final class NumeralsLayer: CAShapeLayer {
    /// The values are displayed starting from top-center, and
    /// moving in a clockwise direction from there. The first value
    /// will always remain in the top-center position, and to
    /// display objects at custom positions (say to only show one
    /// numeral which represents the current hour), the others
    /// should be represented as empty strings
    public var data: [String] = [] {
        didSet {
            setNeedsDisplay()
        }
    }

    /// The font in which the numerals will be set
    public var font = UIFont.systemFont(ofSize: 20, weight: .light) {
        didSet {
            setNeedsDisplay()
        }
    }

    /// The color for the numerals
    public var color = UIColor.white {
        didSet {
            strokeColor = color.cgColor
            setNeedsDisplay()
        }
    }

    public override func draw(in ctx: CGContext) {
        let radius = min(bounds.width, bounds.height) / 2

        /// Magic math to ensure that the text is rendered
        /// correctly.

        ctx.translateBy(x: 0.0, y: bounds.height)
        ctx.scaleBy(x: 1.0, y: -1.0)

        /// The circle representing the text circumference
        /// is slightly inset to ensure that the centers of
        /// the strings are all on the circumference of a
        /// singular circle
        let points = points(data.count, aroundCircleWithCenter: CGPoint(x: bounds.midX, y: bounds.midY), radius: radius - font.pointSize/2)

        for (text, point) in zip(data, points) {
            let attr = [
                NSAttributedString.Key.font: font,
                NSAttributedString.Key.foregroundColor: color] as CFDictionary
            let attrStr = CFAttributedStringCreate(nil, text as CFString, attr)

            let line = CTLineCreateWithAttributedString(attrStr!)
            let bounds = CTLineGetBoundsWithOptions(line, CTLineBoundsOptions.useOpticalBounds)

            ctx.setLineWidth(1.5)
            ctx.setTextDrawingMode(.fill)

            /// Text is placed such that their centers are
            /// equidistant points on the circumference of
            /// a circle within the bounds of the layer

            let newX = point.x - bounds.width/2
            let newY = point.y - bounds.midY
            ctx.textPosition = CGPoint(x: newX, y: newY)
            CTLineDraw(line, ctx)
        }
    }
}
