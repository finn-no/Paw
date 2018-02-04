//
//  Copyright © FINN.no AS, Inc. All rights reserved.
//

import Foundation

public struct GalleryComponent: Component {
    public let id: String
    public let loadables: [Loadable]

    public init(id: String = UUID().uuidString, loadables: [Loadable]) {
        self.id = id
        self.loadables = loadables
    }
}
