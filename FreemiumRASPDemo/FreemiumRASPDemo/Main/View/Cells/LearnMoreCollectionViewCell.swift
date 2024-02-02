//
//  LearnMoreCollectionViewCell.swift
//  FreemiumRASPDemo
//
//  Created by Karolina Škunca on 02.02.2024..
//

import UIKit

class LearnMoreCollectionViewCell: UICollectionViewCell {
    
    static let reuseIdentifier = "LearnMoreCollectionViewCell"
    
    lazy var titleLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: frame.width - 10, height: 18))
        label.textColor = .white
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()
    
    lazy var borderView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: frame.width, height: 50))
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupUI()
        self.setupTexts()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        self.setupUI()
        self.setupTexts()
    }
    
    let borderColors: [CGColor] = [Constants.Color.ACCENT_BLUE.cgColor, Constants.Color.ACCENT_GREEN.cgColor]
    
    func setupUI() {
        
        addSubview(borderView)
        addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            titleLabel.widthAnchor.constraint(equalToConstant: frame.width - 22),
            
            borderView.centerXAnchor.constraint(equalTo: centerXAnchor),
            borderView.centerYAnchor.constraint(equalTo: centerYAnchor),
            borderView.widthAnchor.constraint(equalToConstant: frame.width),
            borderView.heightAnchor.constraint(equalToConstant: 50)
            
        ])
        
        addGradientToBorder()
        addGradientToText()
    }
    
    func setupTexts() {
        titleLabel.text = Constants.Texts.LEARN_MORE_BUTTON
    }
    
    func addGradientToBorder() {
        
        let gradient = CAGradientLayer()
        gradient.frame = borderView.bounds
        gradient.colors = borderColors
        
        let shape = CAShapeLayer()
        shape.path = UIBezierPath(roundedRect: borderView.bounds.insetBy(dx: 4, dy: 4), cornerRadius: 10).cgPath
        shape.lineWidth = 3
        shape.strokeColor = UIColor.black.cgColor
        shape.fillColor = UIColor.clear.cgColor
        gradient.mask = shape
        
        borderView.layer.addSublayer(gradient)
    }
    
    func addGradientToText() {
        let gradient = CAGradientLayer()
        gradient.frame = titleLabel.bounds
        gradient.colors = borderColors
        
        titleLabel.textColor = gradientColor(bounds: titleLabel.bounds, gradientLayer: gradient)
    }
    
    func gradientColor(bounds: CGRect, gradientLayer :CAGradientLayer) -> UIColor? {
        UIGraphicsBeginImageContext(gradientLayer.bounds.size)
        //create UIImage by rendering gradient layer.
        gradientLayer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        //get gradient UIcolor from gradient UIImage
        return UIColor(patternImage: image!)
    }
}
