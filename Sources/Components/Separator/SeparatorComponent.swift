//
//  Copyright © FINN.no AS, Inc. All rights reserved.
//

import Foundation

public struct SeparatorComponent: Component {
    public let id: String

    public init(id: String = UUID().uuidString) {
        self.id = id
    }
}
