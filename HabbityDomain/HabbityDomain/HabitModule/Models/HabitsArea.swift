//
//  HabitsArea.swift
//  HabbityDomain
//
//  Created by Vladyslav Panevnyk on 11.02.2020.
//  Copyright © 2020 Vladyslav Panevnyk. All rights reserved.
//

public struct HabitsArea {
    public var habitAreaTitle: String
    public var habits: [Habit]
}

extension HabitsArea: Equatable {
    public static func == (lhs: HabitsArea, rhs: HabitsArea) -> Bool {
        return lhs.habitAreaTitle == rhs.habitAreaTitle
            && lhs.habits == rhs.habits
    }
}
