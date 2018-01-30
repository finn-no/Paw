import Foundation
import XCTest
@testable import Components

class DateTableComponentTests: XCTestCase {
    let norwegianTitleString = "Sist endret"
    let americanTitleString = "Last changed"

    let norwegianLocale = Locale(identifier: "no_NO")
    let americanLocale = Locale(identifier: "us_US")
    let utcTimeZone = TimeZone(abbreviation: "UTC")!

    let norwegianDateAndTimeString = "30. mar. 2014, 09:13"
    let americanDateAndTimeString = "Mar 30, 2014 at 9:13 AM"

    let norwegianDateString = "søndag 30. mars 2014"
    let americanDateString = "Sunday, March 30, 2014"

    let norwegianTimeString = "09:13:00 GMT"
    let americanTimeString = "9:13:00 AM GMT"

    let yearString = "2014"
    let date = Date.dateWithHourAndTimeZoneString("2014-03-30T09:13:00.000Z")

    func testTitleLabel() {
        let norwegianDateAndTimeTableComponent = DateTableComponent(title: norwegianTitleString, date: date, locale: norwegianLocale)
        let americanDateAndTimeTableComponent = DateTableComponent(title: americanTitleString, date: date, locale: americanLocale)

        XCTAssertEqual(norwegianDateAndTimeTableComponent.title, norwegianTitleString)
        XCTAssertEqual(americanDateAndTimeTableComponent.title, americanTitleString)
    }

    func testDateLabel() {
        let norwegianDateAndTimeTableComponent = DateTableComponent(title: norwegianTitleString, date: date, locale: norwegianLocale, timeZone: utcTimeZone, dateFormat: .dateAndTime)
        let americanDateAndTimeTableComponent = DateTableComponent(title: americanTitleString, date: date, locale: americanLocale, timeZone: utcTimeZone, dateFormat: .dateAndTime)

        let norwegianDateTableComponent = DateTableComponent(title: norwegianTitleString, date: date, locale: norwegianLocale, timeZone: utcTimeZone, dateFormat: .date)
        let americanDateTableComponent = DateTableComponent(title: americanTitleString, date: date, locale: americanLocale, timeZone: utcTimeZone, dateFormat: .date)

        let norwegianTimeTableComponent = DateTableComponent(title: norwegianTitleString, date: date, locale: norwegianLocale, timeZone: utcTimeZone, dateFormat: .time)
        let americanTimeTableComponent = DateTableComponent(title: americanTitleString, date: date, locale: americanLocale, timeZone: utcTimeZone, dateFormat: .time)

        let yearTableComponent = DateTableComponent(title: norwegianTitleString, date: date, locale: norwegianLocale, timeZone: utcTimeZone, dateFormat: .year)

        XCTAssertEqual(norwegianDateAndTimeTableComponent.dateLabel, norwegianDateAndTimeString)
        XCTAssertEqual(americanDateAndTimeTableComponent.dateLabel, americanDateAndTimeString)

        XCTAssertEqual(norwegianDateTableComponent.dateLabel, norwegianDateString)
        XCTAssertEqual(americanDateTableComponent.dateLabel, americanDateString)

        XCTAssertEqual(norwegianTimeTableComponent.dateLabel, norwegianTimeString)
        XCTAssertEqual(americanTimeTableComponent.dateLabel, americanTimeString)

        XCTAssertEqual(yearTableComponent.dateLabel, yearString)
    }

    func testAccessibilityLabel() {
        let norwegianDateAndTimeTableComponent = DateTableComponent(title: norwegianTitleString, date: date, locale: norwegianLocale, timeZone: utcTimeZone, dateFormat: .dateAndTime)
        let americanDateAndTimeTableComponent = DateTableComponent(title: americanTitleString, date: date, locale: americanLocale, timeZone: utcTimeZone, dateFormat: .dateAndTime)

        let norwegianDateTableComponent = DateTableComponent(title: norwegianTitleString, date: date, locale: norwegianLocale, timeZone: utcTimeZone, dateFormat: .date)
        let americanDateTableComponent = DateTableComponent(title: americanTitleString, date: date, locale: americanLocale, timeZone: utcTimeZone, dateFormat: .date)

        let norwegianTimeTableComponent = DateTableComponent(title: norwegianTitleString, date: date, locale: norwegianLocale, timeZone: utcTimeZone, dateFormat: .time)
        let americanTimeTableComponent = DateTableComponent(title: americanTitleString, date: date, locale: americanLocale, timeZone: utcTimeZone, dateFormat: .time)

        let yearTableComponent = DateTableComponent(title: norwegianTitleString, date: date, locale: norwegianLocale, timeZone: utcTimeZone, dateFormat: .year)

        XCTAssertEqual(norwegianDateAndTimeTableComponent.accessibilityLabel, norwegianTitleString + ": " + norwegianDateAndTimeString)
        XCTAssertEqual(americanDateAndTimeTableComponent.accessibilityLabel, americanTitleString + ": " + americanDateAndTimeString)

        XCTAssertEqual(norwegianDateTableComponent.accessibilityLabel, norwegianTitleString + ": " + norwegianDateString)
        XCTAssertEqual(americanDateTableComponent.accessibilityLabel, americanTitleString + ": " + americanDateString)

        XCTAssertEqual(norwegianTimeTableComponent.accessibilityLabel, norwegianTitleString + ": " + norwegianTimeString)
        XCTAssertEqual(americanTimeTableComponent.accessibilityLabel, americanTitleString + ": " + americanTimeString)

        XCTAssertEqual(yearTableComponent.accessibilityLabel, norwegianTitleString + ": " + yearString)
    }
}

extension Date {
    static func dateWithHourAndTimeZoneString(_ dateString: String) -> Date {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        formatter.timeZone = TimeZone(identifier: "GMT")
        let date = formatter.date(from: dateString)!

        return date
    }
}
