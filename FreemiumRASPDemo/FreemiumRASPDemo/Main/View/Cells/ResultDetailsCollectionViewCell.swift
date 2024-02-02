//
//  ResultDetailsCollectionViewCell.swift
//  FreemiumRASPDemo
//
//  Created by Karolina Škunca on 15.01.2024..
//

import UIKit

class ResultDetailsCollectionViewCell: UICollectionViewCell {
    
    static let reuseIdentifier = "ResultDetailsCollectionViewCell"
    
    lazy var iconImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        label.textAlignment = .left
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = Constants.Color.DESCRIPTION_TEXT
        label.font = .systemFont(ofSize: 13)
        label.textAlignment = .left
        label.numberOfLines = 6
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
        addSubview(iconImage)
        addSubview(titleLabel)
        addSubview(descriptionLabel)
        
        NSLayoutConstraint.activate([
            iconImage.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            iconImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            iconImage.heightAnchor.constraint(equalToConstant: 22),
            iconImage.widthAnchor.constraint(equalToConstant: 22),
            
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            titleLabel.leadingAnchor.constraint(equalTo: iconImage.trailingAnchor, constant: 15),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
            descriptionLabel.leadingAnchor.constraint(equalTo: iconImage.trailingAnchor, constant: 15),
            descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
        ])
    }
    
    func setupTexts(imageIcon: UIImage?, titleText: String, descriptionText: String) {
        iconImage.image = imageIcon
        titleLabel.text = titleText
        descriptionLabel.text = descriptionText
    }
}
