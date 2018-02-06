//
//  Copyright © FINN.no AS, Inc. All rights reserved.
//

import Foundation

public struct TextListComponent: Component {
    public let id: String
    let title: String
    let detail: String

    public init(id: String = UUID().uuidString, title: String, detail: String) {
        self.id = id
        self.title = title
        self.detail = detail
    }

    var accessibilityLabel: String? {
        return title + ": " + detail
    }
}
