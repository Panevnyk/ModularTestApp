//
//  CreateHabitAssembly.swift
//  iOSMain
//
//  Created by Vladyslav Panevnyk on 20.02.2020.
//  Copyright © 2020 Vladyslav Panevnyk. All rights reserved.
//

import SwiftUI
import Domain
import CoreDataDB
import iOSUI

final class CreateHabitAssembly {
    let presenter: CreateHabitInteractorOutput
    let interactor: CreateHabitInteractorInput
    let view: CreateHabitView

    init(createHabitDB: CreateHabitDBBoundary) {
        let presenter = CreateHabitPresenter()
        let interactor = CreateHabitInteractor(output: presenter, createHabitDB: createHabitDB)
        let view = CreateHabitView(interactor: interactor)
        presenter.view = view

        self.presenter = presenter
        self.interactor = interactor
        self.view = view
    }
}
