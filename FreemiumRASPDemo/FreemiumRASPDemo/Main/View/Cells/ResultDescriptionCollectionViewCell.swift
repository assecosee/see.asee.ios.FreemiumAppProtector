//
//  ResultDescriptionCollectionViewCell.swift
//  FreemiumRASPDemo
//
//  Created by Karolina Škunca on 15.01.2024..
//

import UIKit

class ResultDescriptionCollectionViewCell: UICollectionViewCell {
    
    static let reuseIdentifier = "ResultDescriptionCollectionViewCell"
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        label.textAlignment = .left
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 16)
        label.textAlignment = .left
        label.numberOfLines = 5
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setupUI() {
        backgroundColor = Constants.Color.SECONDARY_DARK_BLUE
        layer.cornerRadius = 10
        
        addSubview(titleLabel)
        addSubview(descriptionLabel)
        
        NSLayoutConstraint.activate([
            
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            titleLabel.heightAnchor.constraint(equalToConstant: 20),
            
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
            descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            descriptionLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
        ])
    }
    
    func setupTexts(titleColor: UIColor, titleText: String, descriptionText: String) {
        titleLabel.textColor = titleColor
        titleLabel.text = titleText
        descriptionLabel.text = descriptionText
    }
}
