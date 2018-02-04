//
//  Copyright © FINN.no AS, Inc. All rights reserved.
//

import Foundation

public struct GalleryComponent: Component {
    public let id: String
    public let stringURLs: [String]
    public let placeholder: UIImage

    public init(id: String = UUID().uuidString, stringURLs: [String], placeholder: UIImage) {
        self.id = id
        self.stringURLs = stringURLs
        self.placeholder = placeholder
    }
}
