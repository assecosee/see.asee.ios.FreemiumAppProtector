//
//  DetectionPercentageCircleView.swift
//  FreemiumRASPDemo
//
//  Created by Karolina Škunca on 17.01.2024..
//

import UIKit

class DetectionPercentageCircleView: UIView {
    
    let borderWidth: CGFloat = 15.0
    
    var borderColors: [CGColor] = [Constants.Color.ACCENT_BLUE.cgColor,
                                    Constants.Color.ACCENT_GREEN.cgColor,
                                    Constants.Color.RED.cgColor]
    
    var backCircleMaskLayer: CAShapeLayer = CAShapeLayer()
    var progressCircleMaskLayer: CAShapeLayer = CAShapeLayer()
    var gradientLayer: CAGradientLayer = CAGradientLayer()
    
    var progress: Double = 0.0 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    override func draw(_ rect: CGRect) {
        
        let radius = min(bounds.width, bounds.height) / 2.0 - borderWidth / 2.0
        
        let backgroundCircle = UIBezierPath(arcCenter: .zero, radius: radius, startAngle: 0, endAngle: 2 * .pi, clockwise: true)
        backCircleMaskLayer.path = backgroundCircle.cgPath
        backCircleMaskLayer.lineWidth = borderWidth
        backCircleMaskLayer.strokeColor = Constants.Color.SECONDARY_DARK_BLUE.cgColor
        backCircleMaskLayer.fillColor = UIColor.clear.cgColor
        backCircleMaskLayer.position = CGPoint(x: frame.size.width / 2.0, y: frame.size.width / 2.0)
        
        layer.addSublayer(backCircleMaskLayer)
        
        gradientLayer.type = .conic
        gradientLayer.frame = bounds
        gradientLayer.colors = borderColors
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 0.0)
        
        let progressCircle = UIBezierPath(arcCenter: .zero, radius: radius, startAngle: -CGFloat.pi / 2, endAngle: -CGFloat.pi / 2 + CGFloat(2 * .pi * progress), clockwise: true)
        progressCircleMaskLayer.path = progressCircle.cgPath
        progressCircleMaskLayer.lineWidth = borderWidth
        progressCircleMaskLayer.strokeColor = UIColor.white.cgColor
        progressCircleMaskLayer.fillColor = UIColor.clear.cgColor
        progressCircleMaskLayer.position = CGPoint(x: frame.size.width / 2.0, y: frame.size.width / 2.0)
        progressCircleMaskLayer.strokeStart = 0
        progressCircleMaskLayer.strokeEnd = 0
        
        gradientLayer.mask = progressCircleMaskLayer
        
        progressAnimation(duration: 1.25)
    }
    
    func progressAnimation(duration: TimeInterval) {
        
        let circularProgressAnimation = CABasicAnimation(keyPath: "strokeEnd")
        circularProgressAnimation.duration = duration
        circularProgressAnimation.toValue = 1.0
        circularProgressAnimation.fillMode = .forwards
        circularProgressAnimation.isRemovedOnCompletion = false
        progressCircleMaskLayer.add(circularProgressAnimation, forKey: "progressAnim")
        
        layer.addSublayer(gradientLayer)
    }
    
}
