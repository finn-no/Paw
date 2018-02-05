//
//  Copyright © FINN.no AS, Inc. All rights reserved.
//

import Foundation

public struct GalleryComponent: Component {
    public let id: String
    public let placeholder: UIImage
    public let stringURLs: [String]

    public init(id: String = UUID().uuidString, placeholder: UIImage, stringURLs: [String]) {
        self.id = id
        self.placeholder = placeholder
        self.stringURLs = stringURLs
    }
}
