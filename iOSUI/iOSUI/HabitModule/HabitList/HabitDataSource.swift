//
//  PlaceDataSource.swift
//  iOSUI
//
//  Created by Vladyslav Panevnyk on 18.12.2019.
//  Copyright © 2019 Vladyslav Panevnyk. All rights reserved.
//

import Combine
import SwiftUI

class HabitDataSource: ObservableObject {
    @Published var habitViewModels: [HabitViewModel] = []
}
