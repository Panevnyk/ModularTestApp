//
//  CreateHabitPresenter.swift
//  HabbityIOSUI
//
//  Created by Vladyslav Panevnyk on 11.02.2020.
//  Copyright © 2020 Vladyslav Panevnyk. All rights reserved.
//

import UIKit
import HabbityDomain

public protocol CreateHabitPresenterOutput {
    func displayHabitAddedSuccessfuly()
    func displayHabitAddingFailure()
}

final public class CreateHabitPresenter: CreateHabitInteractorOutput {
    public var view: CreateHabitPresenterOutput?

    public init() {}

    public func present(habit: Habit) {}

    public func presentHabitAddedSuccessfuly() {
        view?.displayHabitAddedSuccessfuly()
    }
    
    public func presentHabitAddingFailure() {
        view?.displayHabitAddingFailure()
    }
}
