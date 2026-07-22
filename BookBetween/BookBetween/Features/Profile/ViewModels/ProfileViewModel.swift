//
//  ProfileViewModel.swift
//  BookBetween
//

import Foundation
import Observation

// MARK: - 마이페이지 뷰 모델

@Observable
@MainActor
final class ProfileViewModel {
    // MARK: - 속성

    private let calendar: Calendar

    var displayedMonth: Date

    var calendarDays: [CalendarDay] {
        makeCalendarDays(for: displayedMonth)
    }

    // MARK: - 초기화

    init(
        calendar: Calendar = .current,
        displayedMonth: Date = Date()
    ) {
        var sundayFirstCalendar = calendar
        sundayFirstCalendar.firstWeekday = 1

        self.calendar = sundayFirstCalendar
        self.displayedMonth = displayedMonth
    }

    // MARK: - 캘린더 날짜 생성

    private func makeCalendarDays(for month: Date) -> [CalendarDay] {
        let monthComponents = calendar.dateComponents([.year, .month], from: month)

        guard
            let monthStart = calendar.date(from: monthComponents),
            let daysInMonth = calendar.range(of: .day, in: .month, for: monthStart)?.count
        else {
            return []
        }

        let firstWeekday = calendar.component(.weekday, from: monthStart)
        let leadingDayCount = (firstWeekday - calendar.firstWeekday + 7) % 7
        let requiredDayCount = leadingDayCount + daysInMonth
        let cellCount = ((requiredDayCount + 6) / 7) * 7

        guard let calendarStartDate = calendar.date(
            byAdding: .day,
            value: -leadingDayCount,
            to: monthStart
        ) else {
            return []
        }

        return (0..<cellCount).compactMap { offset in
            guard let date = calendar.date(
                byAdding: .day,
                value: offset,
                to: calendarStartDate
            ) else {
                return nil
            }

            return CalendarDay(
                date: date,
                day: calendar.component(.day, from: date),
                isCurrentMonth: calendar.isDate(
                    date,
                    equalTo: monthStart,
                    toGranularity: .month
                )
            )
        }
    }
}
