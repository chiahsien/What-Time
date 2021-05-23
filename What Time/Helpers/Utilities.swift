//
//  Utilities.swift
//  What Time
//
//  Created by Nelson on 2021/5/22.
//

import UIKit

///
/// Most of the codes are from
/// https://github.com/HarshilShah/Watchface
///

typealias Degrees = CGFloat
extension Degrees {
    /// Returns the value of the current angle as converted to radians.
    /// Uses the relationship 2 * pi = 360 degrees
    public var inRadians: CGFloat {
        return self * .pi / 180
    }
}

/// A method to get an array of points representing the circumference of
/// a circle.
///
/// The points are calculated starting from the top-center, moving in a
/// clockwise direction from there.
///
/// - Parameters:
///   - numberOfPoints: The number of points into which the circle
///     must be split into
///   - center: The center of the circle
///   - radius: The radius of the circle
/// - Returns: An `Array` of `CGPoint`s
func points(_ numberOfPoints: Int, aroundCircleWithCenter center: CGPoint, radius: CGFloat) -> [CGPoint] {
    let rotationAdjustment = Degrees(270).inRadians
    let rotationPerPoint = Degrees(360/CGFloat(numberOfPoints)).inRadians

    var points = [CGPoint]()
    for i in 0 ..< numberOfPoints {
        let currentAngle = (rotationPerPoint * CGFloat(i) * -1) + rotationAdjustment

        /// Equation of a circle is given as (Rcos(theta), Rsin(theta))
        let newX = center.x - (radius * cos(currentAngle))
        let newY = center.y - (radius * sin(currentAngle))

        let newPoint = CGPoint(x: newX, y: newY)
        points.append(newPoint)
    }

    return points
}
