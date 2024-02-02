//
//  ViewControllerModel.swift
//  FreemiumRASPDemo
//
//  Created by Karolina Škunca on 15.01.2024..
//

import UIKit
import AppProtectorFreeSDK

struct ViewControllerModel {
    var model: [DetectionResults]
}

enum DetectionResults {
    case detectionButton
    case resultExplanation(item: DetectionInformation)
    case resultDetails(item: [DetectionDetail?])
    case learnMore
}

enum DetectionInformation {
    case low
    case medium
    case high
}

extension DetectionInformation {
    var explanationTitle: String {
        switch self {
        case .low:
            return Constants.Texts.LOW_DETECTION_EXPLANATION
        case .medium:
            return Constants.Texts.MEDIUM_DETECTION_EXPLANATION
        case .high:
            return Constants.Texts.HIGH_DETECTION_EXPLANATION
        }
    }
    
    var explanationDescription: String {
        switch self {
        case .low:
            return Constants.Texts.LOW_DETECTION_EXPLANATION_DESCRIPTION
        case .medium:
            return Constants.Texts.MEDIUM_DETECTION_EXPLANATION_DESCRIPTION
        case .high:
            return Constants.Texts.HIGH_DETECTION_EXPLANATION_DESCRIPTION
        }
    }
    
    var color: UIColor {
        switch self {
        case .low:
            return Constants.Color.ACCENT_BLUE
        case .medium:
            return Constants.Color.ACCENT_GREEN
        case .high:
            return Constants.Color.RED
        }
    }
}

enum DetectionDetail {
    
    case jailbreakDetected
    case jailbreakNotDetected
    case unofficalCodeSignatureDetected
    case unofficalCodeSignatureNotDetected
    case untrustedSourceDetected
    case untrustedSourceNotDetected
    
}

extension DetectionDetail {
    
    var tamperingType: DetectionTamperingType? {
        switch self {
        case .jailbreakDetected:
            return .Jailbreak
        case .jailbreakNotDetected:
            return nil
        case .unofficalCodeSignatureDetected:
            return .UnofficalCodeSignature
        case .unofficalCodeSignatureNotDetected:
            return nil
        case .untrustedSourceDetected:
            return .UntrustedSource
        case .untrustedSourceNotDetected:
            return nil
        }
    }
    
    var title: String {
        switch self {
        case .jailbreakDetected:
            return Constants.Texts.JAILBREAK_DETECTED_TITLE
        case .jailbreakNotDetected:
            return Constants.Texts.JAILBREAK_NOT_DETECTED_TITLE
        case .unofficalCodeSignatureDetected:
            return Constants.Texts.UNOFFICIAL_CODE_SIGNATURE_DETECTED_TITLE
        case .unofficalCodeSignatureNotDetected:
            return Constants.Texts.UNOFFICIAL_CODE_SIGNATURE_NOT_DETECTED_TITLE
        case .untrustedSourceDetected:
            return Constants.Texts.UNTRUSTED_SOURCE_DETECTED_TITLE
        case .untrustedSourceNotDetected:
            return Constants.Texts.UNTRUSTED_SOURCE_NOT_DETECTED_TITLE
        }
    }
    
    var descriptionMessage: String {
        switch self {
        case .jailbreakDetected:
            return Constants.Texts.JAILBREAK_DETECTED_DESCRIPTION
        case .jailbreakNotDetected:
            return Constants.Texts.JAILBREAK_NOT_DETECTED_DESCRIPTION
        case .unofficalCodeSignatureDetected:
            return Constants.Texts.UNOFFICIAL_CODE_SIGNATURE_DETECTED_DESCRIPTION
        case .unofficalCodeSignatureNotDetected:
            return Constants.Texts.UNOFFICIAL_CODE_SIGNATURE_NOT_DETECTED_DESCRIPTION
        case .untrustedSourceDetected:
            return Constants.Texts.UNTRUSTED_SOURCE_DETECTED_DESCRIPTION
        case .untrustedSourceNotDetected:
            return Constants.Texts.UNTRUSTED_SOURCE_NOT_DETECTED_DESCRIPTION
        }
    }
    
    var icon: UIImage? {
        switch self {
        case .jailbreakDetected:
            return Constants.Images.XMARK
        case .jailbreakNotDetected:
            return Constants.Images.CHECKMARK
        case .unofficalCodeSignatureDetected:
            return Constants.Images.XMARK
        case .unofficalCodeSignatureNotDetected:
            return Constants.Images.CHECKMARK
        case .untrustedSourceDetected:
            return Constants.Images.XMARK
        case .untrustedSourceNotDetected:
            return Constants.Images.CHECKMARK
        }
    }
    
}
