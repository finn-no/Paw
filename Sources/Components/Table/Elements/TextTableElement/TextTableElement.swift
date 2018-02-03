import Foundation

public struct TextTableElement: TableElement {
    public let title: String
    let detail: String

    public init(title: String, detail: String) {
        self.title = title
        self.detail = detail
    }

    var accessibilityLabel: String? {
        return title + ": " + detail
    }
}
