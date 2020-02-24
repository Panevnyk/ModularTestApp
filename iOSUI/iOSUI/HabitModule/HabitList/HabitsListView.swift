//
//  PlaceView.swift
//  iOSUI
//
//  Created by Vladyslav Panevnyk on 17.12.2019.
//  Copyright © 2019 Vladyslav Panevnyk. All rights reserved.
//

import SwiftUI
import Combine
import BusinessLogic

public protocol HabitsListViewCoordinatorDelegate {
    func createHabitViewAction(completion: OptionalClosure)
}

public struct HabitsListView: View {
    // MARK: - Properties

    // Boundaries
    private var interactor: HabitListInteractorInput?

    // Delegates
    public var coordinatorDelegate: HabitsListViewCoordinatorDelegate?

    // UI
    @State
    private var selection: Int? = nil
    @ObservedObject
    private var dataSource = HabitDataSource()

    // MARK: - Init
    public init(interactor: HabitListInteractorInput?) {
        self.interactor = interactor
        setupUI()
    }
    
    // MARK: - Body
    public var body: some View {
        NavigationView {
            VStack {
                List() {
                    ForEach(dataSource.habitViewModels) { viewModel in
                        HabitRowView(viewModel: viewModel)
                    }.onDelete(perform: deleteItems)
                }
            }
            .navigationBarTitle(Text("Habits"))
            .navigationBarItems(trailing:
                CreateHabitButton(action: { self.createHabitAction() }))
        }
        .onAppear(perform: fetchData)
    }

    // TODO: - Shoud be used after close create action
    private func fetchData() {
        interactor?.loadHabits()
    }

    private func createHabitAction() {
        coordinatorDelegate?.createHabitViewAction {
            self.fetchData()
        }
    }
    
    private func deleteItems(at indexSet: IndexSet) {
//        indexSet.forEach { index in
//            interactor?.removePlace(by: index)
//        }
//        dataSource.habitViewModels.remove(atOffsets: indexSet)
    }
}

// MARK: UI methods
private extension HabitsListView {
    func setupUI() {
        UITableView.appearance().tableFooterView = UIView()
    }
}

// MARK: PlacePresenterOutput
extension HabitsListView: HabitListPresenterOutput {
    public func display(habitViewModels: [HabitViewModel]) {
        dataSource.habitViewModels = habitViewModels
    }
}

// MARK: - PreviewProvider
struct PlaceView_Previews: PreviewProvider {
    static var previews: some View {
        HabitsListView(interactor: nil)
    }
}
