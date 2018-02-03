//
//  Copyright © FINN.no AS, Inc. All rights reserved.
//

import Foundation

public struct TableComponent: Component {
    public let id: String
    let components: [TableElement]

    public init(id: String = UUID().uuidString, components: [TableElement]) {
        self.id = id
        self.components = components
    }
}
