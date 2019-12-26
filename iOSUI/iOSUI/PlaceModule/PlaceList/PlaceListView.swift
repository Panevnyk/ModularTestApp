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

public struct PlaceListView: View {
    // MARK: - Properties
    @State
    private var selection: Int? = nil
    @State
    var showingAddPlace = false
    @ObservedObject
    private var dataSource = PlaceDataSource()
    
    private var interactor: PlaceInteractorInput?
    
    var profileButton: some View {
        Button(action: { self.showingAddPlace.toggle() }) {
            Image(systemName: "pencil.tip.crop.circle.badge.plus")
                .imageScale(.large)
                .accessibility(label: Text("User Profile"))
                .padding()
        }
    }
    
    // MARK: - Init
    public init(interactor: PlaceInteractorInput?) {
        self.interactor = interactor
        setupUI()
    }
    
    // MARK: - Body
    public var body: some View {
        NavigationView {
            VStack {
                List() {
                    ForEach(dataSource.placeViewModels) { viewModel in
                        PlaceRowView(viewModel: viewModel)
                    }.onDelete(perform: deleteItems)
                }
            }
            .navigationBarTitle(Text("List of places"))
            .navigationBarItems(trailing: profileButton)
            .sheet(isPresented: $showingAddPlace, onDismiss: fetchData) {
                AddPlaceView(interactor: self.interactor)
            }
        }
        .onAppear(perform: fetchData)
    }
    
    private func fetchData() {
        interactor?.getAllSortedPlaces()
    }
    
    private func deleteItems(at indexSet: IndexSet) {
        indexSet.forEach { index in
            interactor?.removePlace(by: index)
        }
        dataSource.placeViewModels.remove(atOffsets: indexSet)
    }
}

// MARK: UI methods
private extension PlaceListView {
    func setupUI() {
        UITableView.appearance().tableFooterView = UIView()
    }
}

// MARK: PlacePresenterOutput
extension PlaceListView: PlacePresenterOutput {
    public func display(placeViewModels: [PlaceViewModel]) {
        dataSource.placeViewModels = placeViewModels
    }
}

// MARK: - PreviewProvider
struct PlaceView_Previews: PreviewProvider {
    static var previews: some View {
        PlaceListView(interactor: nil)
    }
}
