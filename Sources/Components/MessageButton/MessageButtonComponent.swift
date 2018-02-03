import Foundation

public struct MessageButtonComponent: Component {
    public let id: String
    let title: String
    let answerTime: String

    public init(id: String = UUID().uuidString, title: String, answerTime: String) {
        self.id = id
        self.title = title
        self.answerTime = answerTime
    }
}
