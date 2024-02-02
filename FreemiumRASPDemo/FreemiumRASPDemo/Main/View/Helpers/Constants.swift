//
//  Constants.swift
//  FreemiumRASPDemo
//
//  Created by Karolina Škunca on 15.01.2024..
//

import UIKit

struct Constants {
    
    struct Color {
        static let PRIMARY_DARK_BLUE: UIColor = UIColor(red: 0.01961, green: 0, blue: 0.21176, alpha: 1)
        static let ACCENT_BLUE: UIColor = UIColor(red: 0.1843137254901961, green: 0.6196078431372549, blue: 0.8509803921568627, alpha: 1)
        static let ACCENT_GREEN: UIColor = UIColor(red: 0.19608, green: 0.80392, blue: 0.42353, alpha: 1)
        static let SECONDARY_DARK_BLUE: UIColor = UIColor(red: 0.0549, green: 0.02745, blue: 0.31373, alpha: 1)
        static let RED: UIColor = UIColor(red: 0.78824, green: 0.2, blue: 0.20784, alpha: 1)
        static let DESCRIPTION_TEXT: UIColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.65)
    }
    
    struct Images {
        static let ASEE_LOGO: UIImage? = UIImage(named: "logoImage")
        static let CHECKMARK: UIImage? = UIImage(named: "checkmarkCustom")
        static let XMARK: UIImage? = UIImage(named: "xmark")
    }
    
    struct Sizes {
        static let LOGO_IMAGE_HEIGHT: CGFloat = 60
    }
    
    struct Texts {
        static let ANALYSE_INITIAL: String = "Analyze\nApp"
        static let INTRODUCTION: String = "App Protector Freemium SDK enables limited threat detection on mobile devices.\n\nSupported detections for iOS include:\n- Jailbreaking detection for iOS devices\n- Checks if app signature is from an official source\n- Checks if app is downloaded from a trusted store such as App Store\n\nSupported reactions to detected threats:\n- Notify the user\n\nThis app demonstrates how to implement RASP SDK and display results if the device is compromised."
        static let LOW_DETECTION_RESULT: String = "Low"
        static let MEDIUM_DETECTION_RESULT: String = "Medium"
        static let HIGH_DETECTION_RESULT: String = "High"
        static let ANALYSING: String = "Analyzing"
        static let LEARN_MORE_BUTTON: String = "Learn more about the App Protector Solution"
        static let APP_TITLE: String = "Freemium App Protector"
        static let DETAILS_HEADER: String = "Analysis Details"
        
        static let LOW_DETECTION_EXPLANATION: String = "Low Risk"
        static let MEDIUM_DETECTION_EXPLANATION: String = "Medium Risk"
        static let HIGH_DETECTION_EXPLANATION: String = "High Risk"
        
        static let LOW_DETECTION_EXPLANATION_DESCRIPTION: String = "The threat level is low, indicating minimal risk to the device. Your device is currently secure, and there are no significant threats detected. Continue practicing good security habits to maintain a safe environment."
        static let MEDIUM_DETECTION_EXPLANATION_DESCRIPTION: String = "The threat level is moderate, signifying a moderate risk to the device. Below, you can find details on the specific threats detected. It is recommended to address and mitigate these threats to enhance the overall security of your device."
        static let HIGH_DETECTION_EXPLANATION_DESCRIPTION: String = "The threat level is high, suggesting a significant risk to the device. Below, you can find details on the specific threats detected. It is crucial to address and mitigate these threats immediately to ensure the security and integrity of your device."
        
        static let JAILBREAK_DETECTED_TITLE: String = "Device Jailbroken"
        static let JAILBREAK_NOT_DETECTED_TITLE: String = "Device Not Jailbroken"
        static let UNOFFICIAL_CODE_SIGNATURE_DETECTED_TITLE: String = "Unofficial Code Signature"
        static let UNOFFICIAL_CODE_SIGNATURE_NOT_DETECTED_TITLE: String = "Official Code Signature"
        static let UNTRUSTED_SOURCE_DETECTED_TITLE: String = "Installed via Untrusted Source"
        static let UNTRUSTED_SOURCE_NOT_DETECTED_TITLE: String = "Installed via Trusted Source"
        
        static let JAILBREAK_DETECTED_DESCRIPTION: String = "Your device has been compromised with root privileges, posing a significant threat to your personal information. It is strongly recommended to restore your phone for optimal safety and to prevent unauthorized access to sensitive data."
        static let JAILBREAK_NOT_DETECTED_DESCRIPTION: String = "Your device is secure, and all system functionalities are operating as intended. For ongoing protection against emerging threats, it is advisable to keep your operating system and security software up to date."
        static let UNOFFICIAL_CODE_SIGNATURE_DETECTED_DESCRIPTION: String = "App is signed with a profile that is not from an official source, such as a development profile. This indicates potential tampering with the app's integrity, and caution is advised."
        static let UNOFFICIAL_CODE_SIGNATURE_NOT_DETECTED_DESCRIPTION: String = "The app is properly signed from an official source, ensuring its authenticity and integrity. This additional layer of security verifies the code signature, which comes from a recognized and trusted source."
        static let UNTRUSTED_SOURCE_DETECTED_DESCRIPTION: String = "App is not downloaded from a trusted source. This raises concerns about potential tampering with the app. Exercise caution and consider re-downloading the app from an official and reputable source for enhanced security."
        static let UNTRUSTED_SOURCE_NOT_DETECTED_DESCRIPTION: String = "App is downloaded from a trusted source, such as the App Store. This guarantees the app's origin and minimizes the risk of tampering or unauthorized modifications. Always download apps from official and reputable sources to ensure the security of your device."

    }
    
    struct URL {
        static let ASEE_CYBERSECURITY: String = "https://cybersecurity.asee.io"
    }
    
}
