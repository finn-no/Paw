//
//  Copyright © FINN.no AS, Inc. All rights reserved.
//

import UIKit

extension UITextView {
    func sizeOfSringFor(width: CGFloat) -> CGSize {
        let textSize = CGSize(width: width, height: CGFloat(MAXFLOAT))
        return sizeThatFits(textSize)
    }
}
