//
//  CircularView.swift
//  FreemiumRASPDemo
//
//  Created by Karolina Škunca on 15.01.2024..
//

import UIKit

class CircularView: UIView {
    
    var borderColors: [CGColor] = [Constants.Color.ACCENT_BLUE.cgColor, Constants.Color.ACCENT_GREEN.cgColor]
    
    var borderWidth: CGFloat = 0.0
    
    var maskLayer: CAShapeLayer = CAShapeLayer()
    
    init(borderWidth: CGFloat) {
        super.init(frame: .zero)
        self.borderWidth = borderWidth
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        let radius = min(bounds.width, bounds.height) / 2.0 - borderWidth / 2.0
        
        let circularPath = UIBezierPath(arcCenter: .zero, radius: radius, startAngle: 0, endAngle: CGFloat.pi * 2, clockwise: true)
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = borderColors
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        
        maskLayer.path = circularPath.cgPath
        maskLayer.lineWidth = borderWidth
        maskLayer.strokeColor = UIColor.white.cgColor
        maskLayer.fillColor = UIColor.clear.cgColor
        maskLayer.position = CGPoint(x: frame.size.width / 2.0, y: frame.size.width / 2.0)
        
        gradientLayer.mask = maskLayer
        
        layer.addSublayer(gradientLayer)
    }
    
    func animatePulse() {
        let scaleAnimation = CAKeyframeAnimation(keyPath: "transform.scale")
        scaleAnimation.duration = 2.0
        scaleAnimation.values = [0.9, 1, 0.9]
        scaleAnimation.keyTimes = [0, 0.5, 1.0]
        scaleAnimation.timingFunction = CAMediaTimingFunction(name: .easeOut)
        scaleAnimation.repeatCount = .greatestFiniteMagnitude
        maskLayer.add(scaleAnimation, forKey: "scale")
        
        let opacityAnimation = CAKeyframeAnimation(keyPath: #keyPath(CALayer.opacity))
        opacityAnimation.duration = 2.0
        opacityAnimation.values = [0, 1, 0]
        opacityAnimation.keyTimes = [0, 0.5, 1.0]
        opacityAnimation.timingFunction = CAMediaTimingFunction(name: .easeOut)
        opacityAnimation.repeatCount = .greatestFiniteMagnitude
        maskLayer.add(opacityAnimation, forKey: "opacity")
    }
    
    func startLoading() {
        let rotation: CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotation.toValue = Double.pi * 2
        rotation.duration = 10.0
        rotation.isCumulative = true
        rotation.isRemovedOnCompletion = false
        maskLayer.add(rotation, forKey: "rotationAnimation")
    }
    
}
