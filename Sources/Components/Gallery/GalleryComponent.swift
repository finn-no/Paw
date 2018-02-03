import Foundation

public struct GalleryComponent: Component {
    public let id: String

    public init(id: String = UUID().uuidString) {
        self.id = id
    }
}

