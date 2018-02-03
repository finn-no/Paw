//
//  Copyright © FINN.no AS, Inc. All rights reserved.
//

import UIKit

public extension UIFont {
    public static var title1: UIFont {
        let font = UIFont(name: "FINNTypeWebStrippet-Medium", size: 36) ?? UIFont.systemFont(ofSize: 36, weight: .medium)

        return font.scaledFont(forTextStyle: .title1)
    }

    public static var title2: UIFont {
        let font = UIFont(name: "FINNTypeWebStrippet-Light", size: 28) ?? UIFont.systemFont(ofSize: 28, weight: .light)

        return font.scaledFont(forTextStyle: .title2)
    }

    public static var title3: UIFont {
        let font = UIFont(name: "FINNTypeWebStrippet-Light", size: 22.5) ?? UIFont.systemFont(ofSize: 22.5, weight: .light)

        return font.scaledFont(forTextStyle: .title3)
    }

    public static var title4: UIFont {
        let font = UIFont(name: "FINNTypeWebStrippet-Medium", size: 18) ?? UIFont.systemFont(ofSize: 18, weight: .medium)

        return font.scaledFont(forTextStyle: .headline)
    }

    public static var title5: UIFont {
        let font = UIFont(name: "FINNTypeWebStrippet-Medium", size: 14) ?? UIFont.systemFont(ofSize: 14, weight: .medium)

        return font.scaledFont(forTextStyle: .callout)
    }

    public static var body: UIFont {
        let font = UIFont(name: "FINNTypeWebStrippet-Light", size: 18) ?? UIFont.systemFont(ofSize: 18, weight: .light)

        return font.scaledFont(forTextStyle: .body)
    }

    public static var detail: UIFont {
        let font = UIFont(name: "FINNTypeWebStrippet-Light", size: 14) ?? UIFont.systemFont(ofSize: 14, weight: .light)

        return font.scaledFont(forTextStyle: .footnote)
    }

    func scaledFont(forTextStyle textStyle: UIFontTextStyle) -> UIFont {
        if #available(iOS 11.0, *) {
            let fontMetrics = UIFontMetrics(forTextStyle: textStyle)
            return fontMetrics.scaledFont(for: self)
        } else {
            return self
        }
    }
}
