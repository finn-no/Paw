@testable import Components
import Foundation
import XCTest

class TextTableComponentTests: XCTestCase {
    let titleString = "FINN-kode"
    let detailString = "123456789"

    func testTitleLabel() {
        let textTableComponent = TextTableElement(title: titleString, detail: detailString)

        XCTAssertEqual(textTableComponent.title, titleString)
    }

    func testDescriptionLabel() {
        let textTableComponent = TextTableElement(title: titleString, detail: detailString)

        XCTAssertEqual(textTableComponent.detail, detailString)
    }

    func testAccessibilityLabel() {
        let textTableComponent = TextTableElement(title: titleString, detail: detailString)

        XCTAssertEqual(textTableComponent.accessibilityLabel, titleString + ": " + detailString)
    }
}
