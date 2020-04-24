//
//  CreateHabitAssembly.swift
//  HabbityMain
//
//  Created by Vladyslav Panevnyk on 20.02.2020.
//  Copyright © 2020 Vladyslav Panevnyk. All rights reserved.
//

import SwiftUI
import HabbityDomain
import HabbityCoreDataDB
import HabbityIOSUI

final class CreateHabitAssembly {
    let presenter: CreateHabitInteractorOutput
    let interactor: CreateHabitInteractorInput
    var view: CreateHabitView

    init(createHabitDB: CreateHabitDBBoundary, coordinatorDelegate: CreateHabitViewCoordinatorDelegate?) {
        let presenter = CreateHabitPresenter()
        let interactor = CreateHabitInteractor(output: presenter, createHabitDB: createHabitDB)
        let view = CreateHabitView(interactor: interactor, coordinatorDelegate: coordinatorDelegate)
        presenter.view = view

        self.presenter = presenter
        self.interactor = interactor
        self.view = view
    }
}
