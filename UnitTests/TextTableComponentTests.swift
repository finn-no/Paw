import Foundation
import XCTest
@testable import Components

class TextTableComponentTests: XCTestCase {
    let titleString = "FINN-kode"
    let detailString = "123456789"

    func testTitleLabel() {
        let textTableComponent = TextTableComponent(title: titleString, detail: detailString)

        XCTAssertEqual(textTableComponent.title, titleString)
    }

    func testDescriptionLabel() {
        let textTableComponent = TextTableComponent(title: titleString, detail: detailString)

        XCTAssertEqual(textTableComponent.detail, detailString)
    }

    func testAccessibilityLabel() {
        let textTableComponent = TextTableComponent(title: titleString, detail: detailString)

        XCTAssertEqual(textTableComponent.accessibilityLabel, titleString + ": " + detailString)
    }
}
