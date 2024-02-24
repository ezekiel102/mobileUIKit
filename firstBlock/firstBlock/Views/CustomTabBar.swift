//
//  CustomTabBar.swift
//  firstBlock
//
//  Created by Рустем on 18.02.2024.
//

import UIKit

class CustomTabBar: UITabBar {

    // MARK: - Init

    override func draw(_ rect: CGRect) {
        drawTabBar()
    }

    // MARK: - Private properties

    private var tabBarWidth: CGFloat { self.bounds.width }
    private var tabBarHeight: CGFloat { self.bounds.height }
    private var tabBarCenter: CGFloat { self.bounds.width / 2 }
    private let circleRadius: CGFloat = 27
    private var shapeLayer: CALayer?
    private var circleLayer: CALayer?

    // MARK: - Private methods

    private func shapePath() -> CGPath {
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: tabBarWidth, y: 0))
        path.addLine(to: CGPoint(x: tabBarWidth, y: tabBarHeight))
        path.addLine(to: CGPoint(x: 0, y: tabBarHeight))
        path.close()
        return path.cgPath
    }

    private func circlePath() -> CGPath {
        let path = UIBezierPath()
        path.addArc(withCenter: CGPoint(x: tabBarCenter, y: 12),
                    radius: circleRadius,
                    startAngle: .pi,
                    endAngle: 0 * 180 / .pi,
                    clockwise: true)
        return path.cgPath
    }

    private func drawTabBar() {
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = shapePath()
        shapeLayer.strokeColor = UIViewConstants.whiteTwo.cgColor
        shapeLayer.fillColor = UIColor.white.cgColor
        shapeLayer.lineWidth = 1.0
        shapeLayer.shadowPath = shapePath()
        shapeLayer.shadowColor = UIViewConstants.warmGrey.cgColor
        shapeLayer.shadowOffset = .zero
        shapeLayer.shadowRadius = 2

        let circleLayer = CAShapeLayer()
        circleLayer.path = circlePath()
        circleLayer.strokeColor = UIViewConstants.whiteTwo.cgColor
        circleLayer.fillColor = UIColor.white.cgColor
        circleLayer.lineWidth = 1.0
        circleLayer.shadowPath = circlePath()
        circleLayer.shadowColor = UIViewConstants.whiteTwo.cgColor
        circleLayer.shadowOffset = .zero
        circleLayer.shadowRadius = 1

        if let oldShapeLayer = self.shapeLayer {
            self.layer.replaceSublayer(oldShapeLayer, with: shapeLayer)
        } else {
            self.layer.insertSublayer(shapeLayer, at: 0)
        }

        if let oldCircleLayer = self.circleLayer {
            self.layer.replaceSublayer(oldCircleLayer, with: circleLayer)
        } else {
            self.layer.insertSublayer(circleLayer, at: 1)
        }

        self.shapeLayer = shapeLayer
        self.circleLayer = circleLayer
    }

    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        let pointIsInside = super.point(inside: point, with: event)
        if pointIsInside == false {
            for subview in subviews {
                let pointInSubview = subview.convert(point, from: self)
                if subview.point(inside: pointInSubview, with: event) {
                    return true
                }
            }
        }
        return pointIsInside
    }
}
