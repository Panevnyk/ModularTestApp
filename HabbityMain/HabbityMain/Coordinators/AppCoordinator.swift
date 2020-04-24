//
//  AppCoordinator.swift
//  HabbityMain
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
    private var createHabitCompletion: OptionalClosure = nil

    let coreDataService = CoreDataService()

    init?(window: UIWindow?) {
        guard let window = window else { return nil }
        self.window = window
    }

    func start() {
        let habitAssembly = HabitAssembly(habitListDB: coreDataService,
                                          coordinatorDelegate: self)

        let habitListHostingController = UIHostingController(rootView: habitAssembly.view)
        self.habitListViewController = habitListHostingController

        window.rootViewController = habitListHostingController
        window.makeKeyAndVisible()
    }
}

// MARK: - HabitsListViewCoordinatorDelegate
extension AppCoordinator: HabitsListViewCoordinatorDelegate {
    func createHabitViewAction(completion: OptionalClosure) {
        let createHabitAssembly = CreateHabitAssembly(createHabitDB: coreDataService,
                                                      coordinatorDelegate: self)

        if let habitListViewController = habitListViewController {
            let createHabitHostingController = UIHostingController(rootView: createHabitAssembly.view)
            self.createHabitViewController = createHabitHostingController
            habitListViewController.present(createHabitHostingController, animated: true, completion: nil)
            createHabitCompletion = completion
        }
    }
}

// MARK: - CreateHabitViewCoordinatorDelegate
extension AppCoordinator: CreateHabitViewCoordinatorDelegate {
    func dissmiss() {
        createHabitViewController?.dismiss(animated: true)
    }

    func habitAddedSuccessfuly() {
        dissmiss()
        createHabitCompletion?()
    }
}
