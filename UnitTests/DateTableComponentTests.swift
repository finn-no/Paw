import Foundation
import XCTest
@testable import Components

class DateTableComponentTests: XCTestCase {
    let titleString = "Sist endret"
    let locale = Locale(identifier: "no_NO")
    let dateAndTimeString = "6. apr. 2015, 19:16"
    let dateString = "mandag 6. april 2015"
    let timeString = "19:16:40 CEST"
    let yearString = "2015"
    let timeInterval = TimeInterval(exactly: 450033400)!

    func testTitleLabel() {
        let date = Date(timeIntervalSinceReferenceDate: timeInterval)

        let dateAndTimeTableComponent = DateTableComponent(title: titleString, date: date, locale: locale)

        XCTAssertEqual(dateAndTimeTableComponent.title, titleString)
    }

    func testDateLabel() {
        let date = Date(timeIntervalSinceReferenceDate: timeInterval)
        let dateAndTimeTableComponent = DateTableComponent(title: titleString, date: date, locale: locale, dateFormat: .dateAndTime)
        let dateTableComponent = DateTableComponent(title: titleString, date: date, locale: locale, dateFormat: .date)
        let timeTableComponent = DateTableComponent(title: titleString, date: date, locale: locale, dateFormat: .time)
        let yearTableComponent = DateTableComponent(title: titleString, date: date, locale: locale, dateFormat: .year)

        XCTAssertEqual(dateAndTimeTableComponent.dateLabel, dateAndTimeString)
        XCTAssertEqual(dateTableComponent.dateLabel, dateString)
        XCTAssertEqual(timeTableComponent.dateLabel, timeString)
        XCTAssertEqual(yearTableComponent.dateLabel, yearString)
    }

    func testAccessibilityLabel() {
        let date = Date(timeIntervalSinceReferenceDate: timeInterval)
        let dateAndTimeTableComponent = DateTableComponent(title: titleString, date: date, locale: locale, dateFormat: .dateAndTime)
        let dateTableComponent = DateTableComponent(title: titleString, date: date, locale: locale, dateFormat: .date)
        let timeTableComponent = DateTableComponent(title: titleString, date: date, locale: locale, dateFormat: .time)
        let yearTableComponent = DateTableComponent(title: titleString, date: date, locale: locale, dateFormat: .year)

        XCTAssertEqual(dateAndTimeTableComponent.accessibilityLabel, titleString + ": " + dateAndTimeString)
        XCTAssertEqual(dateTableComponent.accessibilityLabel, titleString + ": " + dateString)
        XCTAssertEqual(timeTableComponent.accessibilityLabel, titleString + ": " + timeString)
        XCTAssertEqual(yearTableComponent.accessibilityLabel, titleString + ": " + yearString)
    }
}
