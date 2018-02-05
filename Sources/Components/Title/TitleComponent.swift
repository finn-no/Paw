//
//  Copyright © FINN.no AS, Inc. All rights reserved.
//

import Foundation

public struct TitleComponent: Component {
    public let id: String
    public let text: String

    public init(id: String = UUID().uuidString, text: String) {
        self.id = id
        self.text = text
    }
}
