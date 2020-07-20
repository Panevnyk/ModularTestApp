//
//  HabitScheduleDaysView.swift
//  HabbityIOSUI
//
//  Created by Vladyslav Panevnyk on 13.02.2020.
//  Copyright © 2020 Vladyslav Panevnyk. All rights reserved.
//

import SwiftUI
import HabbityDomain

struct HabitScheduleDaysView: View {
    @Binding
    var scheduleDayViewModels: [ScheduleDayViewModel]

    var body: some View {
        GeometryReader { geometry in
            HStack(alignment: .center, spacing: self.elementSpaces(by: geometry)) {
                ForEach(self.scheduleDayViewModels) { viewModel in
                    HabitScheduleDayView(value: viewModel.value.shortTitle)
                        .frame(width: self.daySide(by: geometry),
                               height: self.daySide(by: geometry))
                        .foregroundColor(.white)
                        .background(viewModel.isSelected ? Color.blue : Color.gray)
                        .cornerRadius(4)
                        .gesture(TapGesture().onEnded {
                            guard let index = self.scheduleDayViewModels
                                .firstIndex(where: { $0.id == viewModel.id }) else { return }
                            withAnimation(.easeInOut(duration: 0.2)) {
                                self.scheduleDayViewModels[index].isSelected.toggle()
                            }
                        })
                }
            }
        }
    }

    private func elementSpaces(by geometry: GeometryProxy) -> CGFloat {
        return geometry.size.width / 27
    }

    private func daySide(by geometry: GeometryProxy) -> CGFloat {
        return geometry.size.width / 9
    }
}

struct HabitScheduleDaysView_Previews: PreviewProvider {
    static var previews: some View {
        HabitScheduleDaysView(scheduleDayViewModels: .constant([
            ScheduleDayViewModel(id: 0, value: .sunday, isSelected: true),
            ScheduleDayViewModel(id: 1, value: .monday, isSelected: true),
            ScheduleDayViewModel(id: 2, value: .tuesday, isSelected: true),
            ScheduleDayViewModel(id: 3, value: .wednesday, isSelected: true),
            ScheduleDayViewModel(id: 4, value: .thursday, isSelected: true),
            ScheduleDayViewModel(id: 5, value: .friday, isSelected: true),
            ScheduleDayViewModel(id: 6, value: .saturday, isSelected: true)]))
    }
}

struct ScheduleDayViewModel: Identifiable {
    public var id: Int
    public var value: HabitScheduleDay
    public var isSelected: Bool
}

extension HabitScheduleDay {
    var shortTitle: String {
        switch self {
        case .sunday:
            return "S"
        case .monday:
            return "M"
        case .tuesday:
            return "T"
        case .wednesday:
            return "W"
        case .thursday:
            return "T"
        case .friday:
            return "F"
        case .saturday:
            return "S"
        }
    }
}

struct HabitScheduleDayView: View {
    var value: String

    var body: some View {
        Text(value)
    }
}
