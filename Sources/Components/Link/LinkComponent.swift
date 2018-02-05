//
//  Copyright © FINN.no AS, Inc. All rights reserved.
//

import UIKit

public struct LinkComponent: Component {
    public let id: String
    let title: String
    let iconImage: UIImage?

    public init(id: String = UUID().uuidString, title: String, iconImage: UIImage? = nil) {
        self.id = id
        self.title = title
        self.iconImage = iconImage
    }
}
