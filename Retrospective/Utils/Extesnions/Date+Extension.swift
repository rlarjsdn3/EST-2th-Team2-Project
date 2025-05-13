//
//  Date+Extension.swift
//  Retrospective
//
//  Created by 김건우 on 5/13/25.
//

import Foundation

extension Date {
    
    /// <#Description#>
    var weekRange: Range<Date>? {
        guard let startOfWeek = startOfWeek,
              let endOfWeek = endOfWeek else { return nil }
        return startOfWeek ..< endOfWeek.addingDayInterval(1)
    }

    /// 현재 날짜가 속한 주의 시작일과 종료일을 튜플로 반환합니다.
    /// - Returns: 주의 시작일 (`startOfWeek`)과 종료일 (`endOfWeek`)을 포함하는 튜플
    var startAndEndOfWeek: (startOfWeek: Date?, endOfWeek: Date?) {
        (startOfWeek, endOfWeek)
    }

    /// 현재 날짜가 속한 주의 시작일 (일요일)을 반환합니다.
    /// - Returns: 주의 시작일 (일요일) 날짜 (Gregorian 캘린더 기준)
    var startOfWeek: Date? {
        let gregorian = Calendar(identifier: .gregorian)
        guard let sunday = gregorian.date(from: gregorian.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self)) else { return nil }
        return gregorian.date(byAdding: .day, value: 0, to: sunday)
    }

    /// 현재 날짜가 속한 주의 종료일 (토요일)을 반환합니다.
    /// - Returns: 주의 종료일 (토요일) 날짜 (Gregorian 캘린더 기준)
    var endOfWeek: Date? {
        let gregorian = Calendar(identifier: .gregorian)
        guard let sunday = gregorian.date(from: gregorian.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self)) else { return nil }
        return gregorian.date(byAdding: .day, value: 6, to: sunday)
    }

    /// 현재 날짜에서 7일 뒤의 날짜를 반환합니다.
    /// - Returns: 현재 날짜로부터 7일 뒤의 날짜
    var nextWeek: Date? {
        let gregorian = Calendar(identifier: .gregorian)
        guard let nextWeek = gregorian.date(byAdding: .day, value: +7, to: self) else { return nil }
        return nextWeek
    }

    /// 현재 날짜에서 7일 전의 날짜를 반환합니다.
    /// - Returns: 현재 날짜로부터 7일 전의 날짜
    var previousWeek: Date? {
        let gregorian = Calendar(identifier: .gregorian)
        guard let previousWeek = gregorian.date(byAdding: .day, value: -7, to: self) else { return nil }
        return previousWeek
    }
}

extension Date {

    /// <#Description#>
    var monthRange: Range<Date>? {
        guard let startOfMonth = self.startOfMonth,
              let endOfMonth = self.endOfMonth
        else { return nil }
        // 범위에 마지막 일자가 포함되지 않으므로 1일(day)을 더합니다.
        return startOfMonth ..< endOfMonth.addingTimeInterval(1)
    }

    var startAndEndOfMonth: (startOfMonth: Date?, endOfMonth: Date?) {
        (startOfMonth, endOfMonth)
    }

    /// <#Description#>
    var startOfMonth: Date? {
        let gregorian = Calendar(identifier: .gregorian)
        guard let startOfMonth = gregorian.date(from: gregorian.dateComponents([.year, .month], from: self)) else { return nil }
        return startOfMonth
    }

    /// <#Description#>
    var endOfMonth: Date? {
        let gregorian = Calendar(identifier: .gregorian)

        guard let startOfMonth = self.startOfMonth,
              let endOfMonth = gregorian.date(byAdding: DateComponents(month: +1, day: -1), to: self.startOfMonth!)
        else { return nil }
        return endOfMonth
    }

    /// 현재 날짜에서 다음 달로 이동한 날짜를 반환합니다.
    /// - Returns: 현재 날짜로부터 정확히 한 달 뒤의 날짜
    var nextMonth: Date? {
        let gregorian = Calendar(identifier: .gregorian)
        guard let nextMonth = gregorian.date(byAdding: .month, value: +1, to: self) else { return nil }
        return nextMonth
    }

    /// 현재 날짜에서 이전 달로 이동한 날짜를 반환합니다.
    /// - Returns: 현재 날짜로부터 정확히 한 달 전의 날짜
    var previousMonth: Date? {
        let gregorian = Calendar(identifier: .gregorian)
        guard let previousMonth = gregorian.date(byAdding: .month, value: -1, to: self) else { return nil }
        return previousMonth
    }
}

extension Date {

    /// 지정된 연, 월, 일을 사용하여 Date 인스턴스를 생성합니다.
    /// - Parameters:
    ///   - year: 생성할 날짜의 연도입니다.
    ///   - month: 생성할 날짜의 월입니다. (1 ~ 12)
    ///   - day: 생성할 날짜의 일입니다. (1 ~ 해당 월의 최대 일수)
    /// - Returns: 지정된 날짜를 나타내는 Date 인스턴스입니다. 날짜가 유효하지 않은 경우 nil을 반환합니다.
    init?(year: Int, month: Int, day: Int) {
        let dateComponent = DateComponents(year: year, month: month, day: day)
        guard let date = Calendar.current.date(from: dateComponent) else { return nil }
        self = date
    }
}


extension Date {

    /// <#Description#>
    /// - Parameter interval: <#interval description#>
    func addingDayInterval(_ interval: TimeInterval) -> Date {
        self.addingTimeInterval(interval * 86_400)
    }

    /// <#Description#>
    /// - Parameters:
    ///   - lhs: <#lhs description#>
    ///   - rhs: <#rhs description#>
    /// - Returns: <#description#>
    @available(*, deprecated, renamed: "addingDayInterval")
    static func + (lhs: Date, rhs: TimeInterval) -> Date {
        lhs.addingTimeInterval(rhs * 86_400)
    }
}

extension Date {

    /// 날짜 형식을 정의하는 열거형입니다.
    enum Format: String {
        /// 연도와 월을 "yyyy. MM" 형식으로 표현합니다. (예: "2024. 01")
        case yyyyMM = "yyyy. MM"

        /// 연도, 월, 일을 "yyyy. MM. dd" 형식으로 표현합니다. (예: "2024. 01. 15")
        case yyyyMMdd = "yyyy. MM. dd"

        /// 월과 연도를 "MMMM yyyy" 형식으로 표현합니다. (예: "January 2024")
        case MMMMyyyy = "MMMM yyyy"

        /// 일을 "d" 형식으로 표현합니다. (예: "15")
        case d = "d"
    }

    /// 지정된 형식으로 날짜를 문자열로 변환합니다.
    /// - Parameters:
    ///   - dateFormat: 사용자 지정 날짜 형식 (문자열)
    ///   - locale: 로케일 (기본값: 영어 (en_us))
    /// - Returns: 지정된 형식으로 포맷된 날짜 문자열
    func formatted(_ dateFormat: String, locale: Locale = Locale(identifier: "en_us")) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(identifier: "ko_kr")
        dateFormatter.locale = locale
        dateFormatter.dateFormat = dateFormat
        return dateFormatter.string(from: self)
    }

    /// 지정된 `Format` 열거형 스타일로 날짜를 문자열로 변환합니다.
    /// - Parameters:
    ///   - formatStyle: 날짜 형식 스타일 (Format 열거형)
    ///   - locale: 로케일 (기본값: 영어 (en_us))
    /// - Returns: 지정된 형식 스타일로 포맷된 날짜 문자열
    func formatted(_ formatStyle: Format, locale: Locale = Locale(identifier: "en_us")) -> String {
        formatted(formatStyle.rawValue, locale: locale)
    }
}
