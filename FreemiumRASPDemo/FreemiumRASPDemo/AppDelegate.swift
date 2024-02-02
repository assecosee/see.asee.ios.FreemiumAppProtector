//
//  AppDelegate.swift
//  FreemiumRASPDemo
//
//  Created by Karolina Škunca on 10.01.2024..
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let navigationController = UINavigationController(rootViewController: RaspViewController())
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()

        return true
    }

}

extension UINavigationController {
   open override var preferredStatusBarStyle: UIStatusBarStyle {
       return .lightContent
   }
}
