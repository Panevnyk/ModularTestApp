//
//  AppCoordinator.swift
//  iOSMain
//
//  Created by Vladyslav Panevnyk on 20.02.2020.
//  Copyright © 2020 Vladyslav Panevnyk. All rights reserved.
//

import UIKit
import SwiftUI
import iOSUI
import Domain
import CoreDataDB

final class AppCoordinator {
    private let window: UIWindow

    private weak var habitListViewController: UIViewController?
    private weak var createHabitViewController: UIViewController?

    let coreDataService = CoreDataService()

    init?(window: UIWindow?) {
        guard let window = window else { return nil }
        self.window = window
    }

    func start() {
        let habitAssembly = HabitAssembly(habitListDB: coreDataService)
        var view = habitAssembly.view
        view.coordinatorDelegate = self

        let habitListHostingController = UIHostingController(rootView: view)
        self.habitListViewController = habitListHostingController

        window.rootViewController = habitListHostingController
        window.makeKeyAndVisible()
    }
}

// MARK: - HabitsListViewCoordinatorDelegate
extension AppCoordinator: HabitsListViewCoordinatorDelegate {
    func createHabitViewAction(completion: OptionalClosure) {
        let createHabitAssembly = CreateHabitAssembly(createHabitDB: coreDataService)
        var view = createHabitAssembly.view
        view.coordinatorDelegate = self

        if let habitListViewController = habitListViewController {
            let createHabitHostingController = UIHostingController(rootView: view)
            self.createHabitViewController = createHabitHostingController
            habitListViewController.present(createHabitHostingController, animated: true, completion: completion)
        }
    }
}

// MARK: - CreateHabitViewCoordinatorDelegate
extension AppCoordinator: CreateHabitViewCoordinatorDelegate {
    func dissmiss() {
        habitListViewController?.dismiss(animated: true)
    }
}
