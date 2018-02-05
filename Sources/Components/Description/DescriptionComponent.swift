//
//  Copyright © FINN.no AS, Inc. All rights reserved.
//

import Foundation

public struct DescriptionComponent: Component {
    public let id: String
    let text: NSAttributedString
    let titleShow: String
    let titleHide: String
    let isCollapsable: Bool

    public init(id: String = UUID().uuidString, text: NSAttributedString, titleShow: String = NSLocalizedString("See more", comment: ""), titleHide: String = NSLocalizedString("See less", comment: ""), isCollapsable: Bool = false) {
        self.id = id
        self.text = text
        self.titleShow = titleShow
        self.titleHide = titleHide
        self.isCollapsable = isCollapsable
    }
}
