//
//  Copyright © FINN.no AS, Inc. All rights reserved.
//

import Foundation
@testable import Smash
import XCTest

class PriceComponentTests: XCTestCase {
    let largePrice: Double = 1_500_000
    let smallPrice: Double = 0

    let norwegianPriceString = "Pris: "
    let americanPriceString = "Price: "
    let status = "Solgt"

    let norwegianLocale = Locale(identifier: "nb_NO")
    let americanLocale = Locale(identifier: "en_US")

    func testPriceLabel() {
        let largeNorwegianComponent = PriceComponent(price: largePrice, locale: norwegianLocale, accessibilityPrefix: norwegianPriceString)
        let largeAmericanComponent = PriceComponent(price: largePrice, locale: americanLocale, accessibilityPrefix: americanPriceString)
        let smallNorwegianComponent = PriceComponent(price: smallPrice, locale: norwegianLocale, accessibilityPrefix: norwegianPriceString)
        let smallAmericanComponent = PriceComponent(price: smallPrice, locale: americanLocale, accessibilityPrefix: americanPriceString)

        XCTAssertEqual(largeNorwegianComponent.priceLabel, "kr 1 500 000,-")
        XCTAssertEqual(largeAmericanComponent.priceLabel, "$1,500,000,-")
        XCTAssertEqual(smallNorwegianComponent.priceLabel, "kr 0,-")
        XCTAssertEqual(smallAmericanComponent.priceLabel, "$0,-")
    }

    func testAccessibilityLabel() {
        let largeNorwegianComponent = PriceComponent(price: largePrice, locale: norwegianLocale, accessibilityPrefix: norwegianPriceString)
        let largeAmericanComponent = PriceComponent(price: largePrice, locale: americanLocale, accessibilityPrefix: americanPriceString)
        let smallNorwegianComponent = PriceComponent(price: smallPrice, locale: norwegianLocale, accessibilityPrefix: norwegianPriceString)
        let smallAmericanComponent = PriceComponent(price: smallPrice, locale: americanLocale, accessibilityPrefix: americanPriceString)

        XCTAssertEqual(largeNorwegianComponent.accessibilityLabel, norwegianPriceString + "1500000kroner")
        XCTAssertEqual(largeAmericanComponent.accessibilityLabel, americanPriceString + "1500000kroner")
        XCTAssertEqual(smallNorwegianComponent.accessibilityLabel, norwegianPriceString + "0kroner")
        XCTAssertEqual(smallAmericanComponent.accessibilityLabel, americanPriceString + "0kroner")
    }

    func testAccessibilityLabelWithStatus() {
        let largeNorwegianComponent = PriceComponent(price: largePrice, locale: norwegianLocale, accessibilityPrefix: norwegianPriceString, status: status)
        let largeAmericanComponent = PriceComponent(price: largePrice, locale: americanLocale, accessibilityPrefix: americanPriceString, status: status)
        let smallNorwegianComponent = PriceComponent(price: smallPrice, locale: norwegianLocale, accessibilityPrefix: norwegianPriceString, status: status)
        let smallAmericanComponent = PriceComponent(price: smallPrice, locale: americanLocale, accessibilityPrefix: americanPriceString, status: status)

        XCTAssertEqual(largeNorwegianComponent.accessibilityLabel, norwegianPriceString + "1500000kroner. " + status)
        XCTAssertEqual(largeAmericanComponent.accessibilityLabel, americanPriceString + "1500000kroner. " + status)
        XCTAssertEqual(smallNorwegianComponent.accessibilityLabel, norwegianPriceString + "0kroner. " + status)
        XCTAssertEqual(smallAmericanComponent.accessibilityLabel, americanPriceString + "0kroner. " + status)
    }
}
