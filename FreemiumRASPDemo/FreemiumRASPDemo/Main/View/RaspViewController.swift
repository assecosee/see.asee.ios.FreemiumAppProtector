//
//  RaspViewController.swift
//  FreemiumRASPDemo
//
//  Created by Karolina Škunca on 10.01.2024..
//

import UIKit
import AppProtectorFreeSDK

class RaspViewController: UIViewController {
    
    private lazy var collectionView : UICollectionView = {
        let collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.minimumLineSpacing = 8
        collectionViewLayout.sectionInset = UIEdgeInsets(top: 10, left: 0.0, bottom: 10, right: 0.0)
        collectionViewLayout.minimumInteritemSpacing = .zero
        let collectionView = UICollectionView(frame: view.frame, collectionViewLayout: collectionViewLayout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isScrollEnabled = true
        collectionView.bounces = true
        collectionView.backgroundColor = .clear
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0.0, bottom: 10, right: 0.0)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.alwaysBounceVertical = true
        collectionView.register(DetectionCollectionViewCell.self, forCellWithReuseIdentifier: DetectionCollectionViewCell.reuseIdentifier)
        collectionView.register(ResultDetailsCollectionViewCell.self, forCellWithReuseIdentifier: ResultDetailsCollectionViewCell.reuseIdentifier)
        collectionView.register(ResultDescriptionCollectionViewCell.self, forCellWithReuseIdentifier: ResultDescriptionCollectionViewCell.reuseIdentifier)
        collectionView.register(ResultDescriptionHeaderCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: ResultDescriptionHeaderCollectionReusableView.reuseIdentifier)
        collectionView.register(LearnMoreCollectionViewCell.self, forCellWithReuseIdentifier: LearnMoreCollectionViewCell.reuseIdentifier)
        collectionView.contentInsetAdjustmentBehavior = .always
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    lazy var aseeLogoImageView: UIImageView = {
        let imageView = UIImageView(image: Constants.Images.ASEE_LOGO)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private var sections: ViewControllerModel = ViewControllerModel(model: [.detectionButton])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    private func setupUI() {
        
        setupNavigationBar()
        
        view.backgroundColor = Constants.Color.PRIMARY_DARK_BLUE
        
        view.addSubview(collectionView)
        view.addSubview(aseeLogoImageView)
        
        let safeArea = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            
            aseeLogoImageView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -5),
            aseeLogoImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            aseeLogoImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            aseeLogoImageView.heightAnchor.constraint(equalToConstant: Constants.Sizes.LOGO_IMAGE_HEIGHT),
            
            collectionView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 0),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            collectionView.bottomAnchor.constraint(equalTo: aseeLogoImageView.topAnchor, constant: -20),
            
        ])
        
    }
    
    private func setupNavigationBar() {
        
        title = Constants.Texts.APP_TITLE
        
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.backgroundColor = .clear
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for:.default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.layoutIfNeeded()
        
        for navItem in(self.navigationController?.navigationBar.subviews)! {
             for itemSubView in navItem.subviews {
                 if let largeLabel = itemSubView as? UILabel {
                     largeLabel.text = self.title
                     largeLabel.numberOfLines = 0
                     largeLabel.lineBreakMode = .byWordWrapping
                 }
             }
        }
    }
    
    private func doDetection(completion: @escaping (([DetectionTamperingType]) -> Void)) {
        
        let detection = RaspFacade.doDetectOnDemand(raspConfiguration: RaspConfig.notifyUserForAll())
        
        completion(detection)
        
    }
    
    private func analyseDetection(detections: [DetectionTamperingType], completion: @escaping ((CGFloat) -> Void)) {
        
        let percentage: Double
        
        if detections.contains(where: { $0 == .Jailbreak }) {
            percentage = 100
        } else {
            percentage = Double(detections.count) / 3.0 * 100.0
        }
        
        var resultExplanation: DetectionInformation = .low
        
        if percentage < 25 {
            resultExplanation = .low
        } else if percentage < 50 {
            resultExplanation = .medium
        } else {
            resultExplanation = .high
        }
        
        let detectionTypes: [DetectionTamperingType] = [.Jailbreak, .UnofficalCodeSignature, .UntrustedSource]
        var detectionDetails: [DetectionDetail?] = []
        
        for type in detectionTypes {
            let detail: DetectionDetail?
            if detections.contains(type) {
                switch type {
                case .Jailbreak:
                    detail = .jailbreakDetected
                case .UnofficalCodeSignature:
                    detail = .unofficalCodeSignatureDetected
                case .UntrustedSource:
                    detail = .untrustedSourceDetected
                default:
                    detail = nil
                }
            } else {
                switch type {
                case .Jailbreak:
                    detail = .jailbreakNotDetected
                case .UnofficalCodeSignature:
                    detail = .unofficalCodeSignatureNotDetected
                case .UntrustedSource:
                    detail = .untrustedSourceNotDetected
                default:
                    detail = nil
                }
            }
            
            detectionDetails.append(detail)
        }
        
        sections.model.append(.resultExplanation(item: resultExplanation))
        sections.model.append(.resultDetails(item: detectionDetails))
        sections.model.append(.learnMore)
        
        completion(percentage)
    }
}

extension RaspViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        let itemInSection = sections.model[section]
        
        switch itemInSection {
            
        case .detectionButton:
            return 1
        case .resultExplanation:
            return 1
        case .resultDetails(item: let tamperings):
            return tamperings.count
        case .learnMore:
            return 1
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sections.model.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let itemInSection = sections.model[indexPath.section]
        
        switch itemInSection {
            
        case .detectionButton:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DetectionCollectionViewCell.reuseIdentifier, for: indexPath) as? DetectionCollectionViewCell else { return UICollectionViewCell() }
            return cell
        case .resultExplanation(item: let data):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ResultDescriptionCollectionViewCell.reuseIdentifier, for: indexPath) as? ResultDescriptionCollectionViewCell else { return UICollectionViewCell() }
            
            cell.setupTexts(titleColor: data.color,
                            titleText: data.explanationTitle,
                            descriptionText: data.explanationDescription)
            
            return cell
        case .resultDetails(item: let data):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ResultDetailsCollectionViewCell.reuseIdentifier, for: indexPath) as? ResultDetailsCollectionViewCell, let cellData = data[indexPath.row] else { return UICollectionViewCell() }
            
            cell.setupTexts(imageIcon: cellData.icon,
                            titleText: cellData.title,
                            descriptionText: cellData.descriptionMessage)
            
            return cell
        case .learnMore:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LearnMoreCollectionViewCell.reuseIdentifier, for: indexPath) as? LearnMoreCollectionViewCell else { return UICollectionViewCell() }
            return cell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = view.frame.width - 40
        
        let itemInSection = sections.model[indexPath.section]
        
        switch itemInSection {
            
        case .detectionButton:
            return CGSize(width: width, height: 270)
        case .resultExplanation:
            return CGSize(width: width + 12, height: 150)
        case .resultDetails:
            return CGSize(width: width, height: 120)
        case .learnMore:
            return CGSize(width: width, height: 120)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let itemInSection = sections.model[indexPath.section]
        
        switch itemInSection {
            
        case .detectionButton:
            
            guard let cell = self.collectionView.cellForItem(at: indexPath) as? DetectionCollectionViewCell else {
                return
            }
            
            switch cell.state {
            case .analyse:
                
                changeCollectionView(cell)
                
            case .detectionResults:
                
                
                _ = self.view.subviews.map { $0.isUserInteractionEnabled = false }
                
                self.sections.model = [.detectionButton]
                cell.changeState(detectionPercentage: 0)
                
                self.collectionView.deleteSections(IndexSet(integersIn: 1...3))
                
                changeCollectionView(cell)
            }
        case .resultExplanation:
            break
        case .resultDetails:
            break
        case .learnMore:
            if let url = URL(string: Constants.URL.ASEE_CYBERSECURITY) {
                UIApplication.shared.open(url)
            }
        }
        
    }
    
    func changeCollectionView(_ cell: DetectionCollectionViewCell) {
        _ = self.view.subviews.map { $0.isUserInteractionEnabled = false }
        
        cell.startLoading()
        
        self.doDetection { tamperingData in
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                self.analyseDetection(detections: tamperingData, completion: { percentage in
                    cell.changeState(detectionPercentage: percentage)
                    self.collectionView.insertSections(IndexSet(integersIn: 1...3))
                    _ = self.view.subviews.map { $0.isUserInteractionEnabled = true }
                })
            }
        }
    }
    
    //Header
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        let itemInSection = sections.model[section]
        
        switch itemInSection {
        case .resultDetails:
            return CGSize(width: view.frame.width - 40, height: 24)
        default:
            return .zero
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let itemInSection = sections.model[indexPath.section]
        
        switch itemInSection {
        case .resultDetails:
            if kind == UICollectionView.elementKindSectionHeader {
                
                guard let reusableview = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: ResultDescriptionHeaderCollectionReusableView.reuseIdentifier, for: indexPath) as? ResultDescriptionHeaderCollectionReusableView else {
                    return UICollectionReusableView()
                }
                
                reusableview.titleLabel.text = Constants.Texts.DETAILS_HEADER
                return reusableview
                
            }
        default:
            break
        }
        
        return UICollectionReusableView()
    }
}

