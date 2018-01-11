import Foundation

struct MessageButtonComponent: Component {

    let id: String

    let title: String
    let answerTime: String

    init(id: String = UUID().uuidString, title: String, answerTime: String) {
        self.id = id
        self.title = title
        self.answerTime = answerTime
    }
}
