//
//  SceneDelegate.swift
//  tip-calculator
//
//  Created by Yasha Serhiienko on 21.06.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let window = UIWindow(windowScene: windowScene)
        let vc = CalculatorVC()
        window.rootViewController = vc
        
        self.window = window
        window.makeKeyAndVisible()
    }
    
}

