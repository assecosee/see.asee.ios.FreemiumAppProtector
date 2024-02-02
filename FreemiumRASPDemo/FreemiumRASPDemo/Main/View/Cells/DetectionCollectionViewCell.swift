//
//  DetectionCollectionViewCell.swift
//  FreemiumRASPDemo
//
//  Created by Karolina Škunca on 15.01.2024..
//

import UIKit

enum State {
    case analyse
    case detectionResults
}

class DetectionCollectionViewCell: UICollectionViewCell {
    
    static let reuseIdentifier = "DetectionCollectionViewCell"
    
    lazy var circleButtonInside: CircularView = {
        let circularView = CircularView(borderWidth: 15)
        circularView.translatesAutoresizingMaskIntoConstraints = false
        return circularView
    }()
    
    lazy var circleButtonOutside: CircularView = {
        let circularView = CircularView(borderWidth: 2)
        circularView.translatesAutoresizingMaskIntoConstraints = false
        return circularView
    }()
    
    lazy var progressCircle: DetectionPercentageCircleView = {
        let circularView = DetectionPercentageCircleView(frame: .zero)
        circularView.translatesAutoresizingMaskIntoConstraints = false
        return circularView
    }()
    
    lazy var circleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 22, weight: .semibold)
        label.textAlignment = .center
        label.contentMode = .center
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 14)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var lowThreatLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white.withAlphaComponent(0.8)
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.textAlignment = .center
        label.contentMode = .center
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var mediumThreatLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white.withAlphaComponent(0.8)
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.textAlignment = .center
        label.contentMode = .center
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var highThreatLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white.withAlphaComponent(0.8)
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.textAlignment = .center
        label.contentMode = .center
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupTexts()
        
        animateOuterCircle()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    var state: State = .analyse
    
    func setupUI() {
        
        addSubview(circleLabel)
        addSubview(circleButtonInside)
        addSubview(circleButtonOutside)
        addSubview(descriptionLabel)
        addSubview(lowThreatLabel)
        addSubview(mediumThreatLabel)
        addSubview(highThreatLabel)
        addSubview(progressCircle)
        
        NSLayoutConstraint.activate([
            
            lowThreatLabel.centerXAnchor.constraint(equalTo: circleButtonInside.centerXAnchor, constant: frame.height / 4 + 40),
            lowThreatLabel.centerYAnchor.constraint(equalTo: circleButtonInside.centerYAnchor, constant: -frame.width / 4),
            
            mediumThreatLabel.centerXAnchor.constraint(equalTo: circleButtonInside.centerXAnchor, constant: 0),
            mediumThreatLabel.centerYAnchor.constraint(equalTo: circleButtonInside.centerYAnchor, constant: frame.width / 4 + 30),
            
            highThreatLabel.centerXAnchor.constraint(equalTo: circleButtonInside.centerXAnchor, constant: -frame.height / 4 - 40),
            highThreatLabel.centerYAnchor.constraint(equalTo: circleButtonInside.centerYAnchor, constant: -frame.width / 4),
            
            circleLabel.centerXAnchor.constraint(equalTo: circleButtonInside.centerXAnchor, constant: 0),
            circleLabel.centerYAnchor.constraint(equalTo: circleButtonInside.centerYAnchor, constant: 0),
            
            circleButtonInside.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 0),
            circleButtonInside.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 0),
            circleButtonInside.heightAnchor.constraint(equalToConstant: 200),
            circleButtonInside.widthAnchor.constraint(equalToConstant: 200),
            
            progressCircle.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 0),
            progressCircle.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 0),
            progressCircle.heightAnchor.constraint(equalToConstant: 200),
            progressCircle.widthAnchor.constraint(equalToConstant: 200),
            
            circleButtonOutside.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 0),
            circleButtonOutside.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 0),
            circleButtonOutside.heightAnchor.constraint(equalToConstant: 220),
            circleButtonOutside.widthAnchor.constraint(equalToConstant: 220),
            
            descriptionLabel.topAnchor.constraint(equalTo: circleButtonOutside.bottomAnchor, constant: 20),
            descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        ])
        
        progressCircle.alpha = 0
        
    }
    
    func setupTexts() {
        circleLabel.text = Constants.Texts.ANALYSE_INITIAL.uppercased()
        descriptionLabel.text = Constants.Texts.INTRODUCTION
    }
    
    func setupTexts(detectionPercentage: CGFloat) {
        
        UIView.transition(with: lowThreatLabel,
                          duration: 0.3,
                          options: .transitionCrossDissolve,
                          animations: { [weak self] in
            guard let `self` = self else { return }
            self.lowThreatLabel.text = Constants.Texts.LOW_DETECTION_RESULT
        }, completion: {_ in
            
            UIView.transition(with: self.mediumThreatLabel,
                              duration: 0.3,
                              options: .transitionCrossDissolve,
                              animations: { [weak self] in
                guard let `self` = self else { return }
                self.mediumThreatLabel.text = Constants.Texts.MEDIUM_DETECTION_RESULT
            }, completion: {_ in
                
                UIView.transition(with: self.highThreatLabel,
                                  duration: 0.3,
                                  options: .transitionCrossDissolve,
                                  animations: { [weak self] in
                    guard let `self` = self else { return }
                    self.highThreatLabel.text = Constants.Texts.HIGH_DETECTION_RESULT
                }, completion: {_ in
                    
                    UIView.transition(with: self.circleLabel,
                                      duration: 0.3,
                                      options: .transitionCrossDissolve,
                                      animations: { [weak self] in
                        guard let `self` = self else { return }
                        self.circleLabel.alpha = 1
                        self.circleLabel.text = String(format: "%.2f", detectionPercentage) + "%"
                    }, completion: {_ in
                        if detectionPercentage < 25 {
                            self.lowThreatLabel.textColor = Constants.Color.ACCENT_BLUE
                        } else if detectionPercentage < 50 {
                            self.mediumThreatLabel.textColor = Constants.Color.ACCENT_GREEN
                        } else {
                            self.highThreatLabel.textColor = Constants.Color.RED
                        }
                    })
                    
                })
                
            })
        })
        
    }
    
    func animateOuterCircle() {
        circleButtonOutside.animatePulse()
    }
    
    func startLoading() {
        
        UIView.transition(with: circleLabel,
                          duration: 0.3,
                          options: .transitionCrossDissolve,
                          animations: { [weak self] in
            guard let `self` = self else { return }
            self.circleLabel.text = Constants.Texts.ANALYSING.uppercased()
        }, completion: nil)
        
        
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut, animations: { [weak self] in
            guard let `self` = self else { return }
            
            self.descriptionLabel.isHidden = true
            
        }, completion: {_ in
            self.circleButtonInside.startLoading()
        })
        
    }
    
    func changeState(detectionPercentage: CGFloat) {
        state = (state == .analyse) ? .detectionResults : .analyse
        
        switch state {
        case .analyse:
            
            animateOuterCircle()
            
            self.setupTexts()
            
            UIView.animate(withDuration: 0.3) {
                self.progressCircle.alpha = 0
                
                
                self.lowThreatLabel.alpha = 0
                self.mediumThreatLabel.alpha = 0
                self.highThreatLabel.alpha = 0
                
                
                self.descriptionLabel.alpha = 1
                self.circleButtonOutside.alpha = 1
                self.circleButtonInside.alpha = 1
                
            }
            
        case .detectionResults:
            
            UIView.animate(withDuration: 0.3) {
                self.circleLabel.alpha = 0
                self.descriptionLabel.alpha = 0
                self.circleButtonOutside.alpha = 0
                self.circleButtonInside.alpha = 0
                
                self.progressCircle.alpha = 1
                
                self.lowThreatLabel.alpha = 1
                self.mediumThreatLabel.alpha = 1
                self.highThreatLabel.alpha = 1
            }
            
            self.progressCircle.progress = detectionPercentage/100
            setupTexts(detectionPercentage: detectionPercentage)
            
        }
    }

}
