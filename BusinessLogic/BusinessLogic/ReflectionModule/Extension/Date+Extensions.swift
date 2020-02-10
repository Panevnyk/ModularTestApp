//
//  Date+Extensions.swift
//  BusinessLogic
//
//  Created by Vladyslav Panevnyk on 10.02.2020.
//  Copyright © 2020 Vladyslav Panevnyk. All rights reserved.
//

extension Date {
    var startOfMonth: Date {
        var calendar = Calendar.current
        calendar.timeZone = TimeZone(secondsFromGMT: 0)!
        let comp: DateComponents = calendar.dateComponents([.year, .month], from: self)
        return calendar.date(from: comp)!
    }

    var endOfMonth: Date {
        var calendar = Calendar.current
        calendar.timeZone = TimeZone(secondsFromGMT: 0)!
        var comps2 = DateComponents()
        comps2.month = 1
        comps2.day = -1
        return calendar.date(byAdding: comps2, to: startOfMonth)!
    }
}
