//
//  CreateHabitPresenter.swift
//  iOSUI
//
//  Created by Vladyslav Panevnyk on 11.02.2020.
//  Copyright © 2020 Vladyslav Panevnyk. All rights reserved.
//

import UIKit
import Domain

public protocol CreateHabitPresenterOutput {
}

final public class CreateHabitPresenter: CreateHabitInteractorOutput {
    public var view: CreateHabitPresenterOutput?

    public init() {}

    public func present(habit: Habit) {

    }

    public func habitAddedSuccessfuly() {
        print("!!! SUCCESS YEAH")
    }
    
    public func habitAddingFailure() {
        print("!!! Failure ((((")
    }
}
