//
//  Copyright © FINN.no AS, Inc. All rights reserved.
//

import Foundation

public struct GalleryComponent: Component {
    public let id: String
    public let urls: [String]

    public init(id: String = UUID().uuidString, urls: [String]) {
        self.id = id
        self.urls = urls
    }
}
