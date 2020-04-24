//
//  PlaceViewModel.swift
//  HabbityIOSUI
//
//  Created by Vladyslav Panevnyk on 18.12.2019.
//  Copyright © 2019 Vladyslav Panevnyk. All rights reserved.
//

import Combine
import SwiftUI

public struct HabitViewModel: Identifiable {
    public var id: Int
    public var title: String
    public var isSelected: Bool
}
