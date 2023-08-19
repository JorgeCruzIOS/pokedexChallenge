//
//  AppDelegate.swift
//  Pokedex
//
//  Created by Dsi Soporte Tecnico on 17/08/23.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        guard let window = window else{
            return true
        }
        let navigation =  UINavigationController()
        window.rootViewController = navigation
        window.backgroundColor = UIColor.init(rgb: 0xF5F6F8)
        window.makeKeyAndVisible()
        UIView.transition(with: window,
                          duration: 0.3,
                          options: .transitionCrossDissolve,
                          animations: nil,
                          completion: nil)
        navigation.pushViewController(SplashScreenViewController(), animated: true)
        return true
    }


}

