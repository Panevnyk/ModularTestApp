//
//  SceneDelegate.swift
//  iOSMain
//
//  Created by Vladyslav Panevnyk on 12/10/19.
//  Copyright © 2019 Vladyslav Panevnyk. All rights reserved.
//

import UIKit
import BusinessLogic
import CoreDataDB
import SwiftUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    lazy var appCoordinator: AppCoordinator? = AppCoordinator(window: window)

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            self.window = window

            appCoordinator?.start()
        }
    }
}
