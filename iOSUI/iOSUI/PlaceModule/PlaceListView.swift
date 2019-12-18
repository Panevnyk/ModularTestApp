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
    @State private var selection: Int? = nil
    @ObservedObject private var dataSource = PlaceDataSource()
    
    private var interactor: PlaceInteractorInput?
    
    // MARK: - Init
    public init(interactor: PlaceInteractorInput?) {
        self.interactor = interactor
    }
    
    // MARK: - Body
    public var body: some View {
        NavigationView {
            VStack {
                List(dataSource.placeViewModels) { viewModel in
                    PlaceRowView(viewModel: viewModel)
                }
                Spacer()
                NavigationLink(destination: DetailsView(), tag: 1, selection: $selection) {
                    Button("Press me") {
                        self.selection = 1
                    }
                }
            }
        }.onAppear(perform: fetch)
    }
    
    func fetch() {
        interactor?.getAllSortedPlaces()
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
