//
//  Copyright © FINN.no AS, Inc. All rights reserved.
//

import UIKit

public struct CustomComponent: Component {
    public let id: String

    public init(id: String = UUID().uuidString) {
        self.id = id
    }
}
