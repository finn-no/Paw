import Foundation
import XCTest
@testable import Components

class DateTableComponentTests: XCTestCase {
    let titleString = "Sist endret"
    let locale = Locale(identifier: "no_NO")
    let dateAndTimeString = "6. apr. 2015, 19:16"
    let dateString = "6. april 2015"
    let timeString = "19:16"
    let yearString = "2015"
    let timeInterval = TimeInterval(exactly: 450033400)!

    lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = locale
        return formatter
    }()

    func testTitleLabel() {
        let date = Date(timeIntervalSinceReferenceDate: timeInterval)

        let dateAndTimeTableComponent = DateTableComponent(title: titleString, date: date, locale: locale)

        XCTAssertEqual(dateAndTimeTableComponent.title, titleString)
    }

    func testDateLabel() {
//        let date = Date(timeIntervalSinceReferenceDate: timeInterval)
//        let dateAndTimeTableComponent = DateTableComponent(title: titleString, date: date, locale: locale, dateFormat: .dateAndTime)
//        let dateTableComponent = DateTableComponent(title: titleString, date: date, locale: locale, dateFormat: .date)
//        let timeTableComponent = DateTableComponent(title: titleString, date: date, locale: locale, dateFormat: .time)
//        let yearTableComponent = DateTableComponent(title: titleString, date: date, locale: locale, dateFormat: .year)
//
//        XCTAssertEqual(dateAndTimeTableComponent.date, dateFormatter.date(from: dateAndTimeString))
//        XCTAssertEqual(dateTableComponent.date, dateFormatter.date(from: dateString))
//        XCTAssertEqual(timeTableComponent.date, dateFormatter.date(from: timeString))
//        XCTAssertEqual(yearTableComponent.date, dateFormatter.date(from: yearString))
    }

    func testAccessibilityLabel() {
//        let textTableComponent = TextTableComponent(title: titleString, detail: detailString)
//
//        XCTAssertEqual(textTableComponent.accessibilityLabel, titleString + ": " + detailString)
    }
}
