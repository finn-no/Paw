import Foundation
import XCTest
@testable import Components

class DateTableComponentTests: XCTestCase {
    let norwegianTitleString = "Sist endret"
    let americanTitleString = "Last changed"

    let norwegianLocale = Locale(identifier: "no_NO")
    let americanLocale = Locale(identifier: "us_US")

    let norwegianDateAndTimeString = "6. apr. 2015, 19:16"
    let americanDateAndTimeString = "Apr 6, 2015 at 7:16 PM"

    let norwegianDateString = "mandag 6. april 2015"
    let americanDateString = "Monday, April 6, 2015"

    let norwegianTimeString = "19:16:40 CEST"
    let americanTimeString = "7:16:40 PM GMT+2"

    let yearString = "2015"
    let timeInterval = TimeInterval(exactly: 450033400)!

    func testTitleLabel() {
        let date = Date(timeIntervalSinceReferenceDate: timeInterval)
        let norwegianDateAndTimeTableComponent = DateTableComponent(title: norwegianTitleString, date: date, locale: norwegianLocale)
        let americanDateAndTimeTableComponent = DateTableComponent(title: americanTitleString, date: date, locale: americanLocale)

        XCTAssertEqual(norwegianDateAndTimeTableComponent.title, norwegianTitleString)
        XCTAssertEqual(americanDateAndTimeTableComponent.title, americanTitleString)
    }

    func testDateLabel() {
        let date = Date(timeIntervalSinceReferenceDate: timeInterval)
        let norwegianDateAndTimeTableComponent = DateTableComponent(title: norwegianTitleString, date: date, locale: norwegianLocale, dateFormat: .dateAndTime)
        let americanDateAndTimeTableComponent = DateTableComponent(title: americanTitleString, date: date, locale: americanLocale, dateFormat: .dateAndTime)

        let norwegianDateTableComponent = DateTableComponent(title: norwegianTitleString, date: date, locale: norwegianLocale, dateFormat: .date)
        let americanDateTableComponent = DateTableComponent(title: americanTitleString, date: date, locale: americanLocale, dateFormat: .date)

        let norwegianTimeTableComponent = DateTableComponent(title: norwegianTitleString, date: date, locale: norwegianLocale, dateFormat: .time)
        let americanTimeTableComponent = DateTableComponent(title: americanTitleString, date: date, locale: americanLocale, dateFormat: .time)

        let yearTableComponent = DateTableComponent(title: norwegianTitleString, date: date, locale: norwegianLocale, dateFormat: .year)

        XCTAssertEqual(norwegianDateAndTimeTableComponent.dateLabel, norwegianDateAndTimeString)
        XCTAssertEqual(americanDateAndTimeTableComponent.dateLabel, americanDateAndTimeString)

        XCTAssertEqual(norwegianDateTableComponent.dateLabel, norwegianDateString)
        XCTAssertEqual(americanDateTableComponent.dateLabel, americanDateString)

        XCTAssertEqual(norwegianTimeTableComponent.dateLabel, norwegianTimeString)
        XCTAssertEqual(americanTimeTableComponent.dateLabel, americanTimeString)

        XCTAssertEqual(yearTableComponent.dateLabel, yearString)
    }

    func testAccessibilityLabel() {
        let date = Date(timeIntervalSinceReferenceDate: timeInterval)
        let norwegianDateAndTimeTableComponent = DateTableComponent(title: norwegianTitleString, date: date, locale: norwegianLocale, dateFormat: .dateAndTime)
        let americanDateAndTimeTableComponent = DateTableComponent(title: americanTitleString, date: date, locale: americanLocale, dateFormat: .dateAndTime)

        let norwegianDateTableComponent = DateTableComponent(title: norwegianTitleString, date: date, locale: norwegianLocale, dateFormat: .date)
        let americanDateTableComponent = DateTableComponent(title: americanTitleString, date: date, locale: americanLocale, dateFormat: .date)

        let norwegianTimeTableComponent = DateTableComponent(title: norwegianTitleString, date: date, locale: norwegianLocale, dateFormat: .time)
        let americanTimeTableComponent = DateTableComponent(title: americanTitleString, date: date, locale: americanLocale, dateFormat: .time)

        let yearTableComponent = DateTableComponent(title: norwegianTitleString, date: date, locale: norwegianLocale, dateFormat: .year)

        XCTAssertEqual(norwegianDateAndTimeTableComponent.accessibilityLabel, norwegianTitleString + ": " + norwegianDateAndTimeString)
        XCTAssertEqual(americanDateAndTimeTableComponent.accessibilityLabel, americanTitleString + ": " + americanDateAndTimeString)

        XCTAssertEqual(norwegianDateTableComponent.accessibilityLabel, norwegianTitleString + ": " + norwegianDateString)
        XCTAssertEqual(americanDateTableComponent.accessibilityLabel, americanTitleString + ": " + americanDateString)

        XCTAssertEqual(norwegianTimeTableComponent.accessibilityLabel, norwegianTitleString + ": " + norwegianTimeString)
        XCTAssertEqual(americanTimeTableComponent.accessibilityLabel, americanTitleString + ": " + americanTimeString)

        XCTAssertEqual(yearTableComponent.accessibilityLabel, norwegianTitleString + ": " + yearString)
    }
}
