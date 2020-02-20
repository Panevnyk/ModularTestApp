//
//  AddPlaceView.swift
//  iOSUI
//
//  Created by Vladyslav Panevnyk on 24.12.2019.
//  Copyright © 2019 Vladyslav Panevnyk. All rights reserved.
//

import SwiftUI
import Combine
import BusinessLogic

public protocol CreateHabitViewCoordinatorDelegate {
    func dissmiss()
}

public struct CreateHabitView: View {
    // MARK: - Properties

    // Boundaries
    private var interactor: CreateHabitInteractorInput?

    // Delegates
    public var coordinatorDelegate: CreateHabitViewCoordinatorDelegate?

    // UI
    @State private var habitTitle = ""
    @State private var creationDate = Date()
    @State private var selectedIndex = 0
    @State private var isShowDatePicker = false
    @State private var scheduleDayViewModels = [
        ScheduleDayViewModel(id: 0, value: .sunday, isSelected: true),
        ScheduleDayViewModel(id: 1, value: .monday, isSelected: true),
        ScheduleDayViewModel(id: 2, value: .tuesday, isSelected: true),
        ScheduleDayViewModel(id: 3, value: .wednesday, isSelected: true),
        ScheduleDayViewModel(id: 4, value: .thursday, isSelected: true),
        ScheduleDayViewModel(id: 5, value: .friday, isSelected: true),
        ScheduleDayViewModel(id: 6, value: .saturday, isSelected: true)]

    private var selectedTimePeriod: HabitTimePeriod {
        switch selectedIndex {
        case 0:
            return .day
        case 1:
            return .week
        case 2:
            return .month
        default:
            return .day
        }
    }

    private let actionSheetContent = ActionSheetContent(title: "Habit time period",
                                                        values: HabitTimePeriod.allCases.map { $0.title })

    private var isAddButtonDisabled: Binding<Bool> {
        Binding(get: {
            self.habitTitle.isEmpty
                || !self.scheduleDayViewModels.contains(where: { $0.isSelected })
        }) { (newVal) in }
    }

    // MARK: - Init
    public init(interactor: CreateHabitInteractorInput?) {
        self.interactor = interactor
    }

    // MARK: - Body
    public var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            HStack {
                Text("Create a habit")
                    .font(.largeTitle)

                Spacer()

                CloseButton(action: closeAction)
            }

            HabitTextField(placeHolder: "Habit title",
                           inputText: $habitTitle)
                .frame(height: 40)

            KeyValueDatePickerView(keyText: "Creation date",
                                   selectedDate: $creationDate,
                                   isShowDatePicker:  $isShowDatePicker)
                .frame(height: isShowDatePicker ? 258 : 40)

            KeyValueActionSheetView(keyText: "Habit time period",
                                    actionSheetContent: actionSheetContent,
                                    selectedIndex: $selectedIndex)
                .frame(height: 40)

            HabitScheduleDaysView(scheduleDayViewModels: $scheduleDayViewModels)
                .frame(height: 40)

            AddButton(isDisabled: isAddButtonDisabled,
                      action: addHabitAction)

            Spacer()
        }
        .padding(.horizontal, 15)
        .padding(.vertical, 15)
    }
}

// MARK: - CreateHabitPresenterOutput
extension CreateHabitView: CreateHabitPresenterOutput {}

// MARK: - Actions
private extension CreateHabitView {
    func addHabitAction() {
        interactor?.setHabitTitle(habitTitle)
        interactor?.setCreationDate(creationDate)
        interactor?.setTimePeriod(selectedTimePeriod)
        interactor?.setSchedule(scheduleDayViewModels.map { $0.value })

        interactor?.addHabit()
    }

    func closeAction() {
        coordinatorDelegate?.dissmiss()
    }
}

struct AddPlaceView_Previews: PreviewProvider {
    static var previews: some View {
        CreateHabitView(interactor: nil)
    }
}

