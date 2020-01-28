//
//  HabitData.swift
//  BusinessLogic
//
//  Created by Vladyslav Panevnyk on 28.01.2020.
//  Copyright © 2020 Vladyslav Panevnyk. All rights reserved.
//

public struct HabitData {
    public var id: UUID
    public var value: Any
    public var date: Date
}

extension HabitData: Equatable {
    public static func == (lhs: HabitData, rhs: HabitData) -> Bool {
        return lhs.id == rhs.id
    }
}
