import UIKit

extension UITextView {
    var sizeOfString: CGSize {
        let textSize = CGSize(width: CGFloat(UIScreen.main.bounds.width - .mediumLargeSpacing*2), height: CGFloat(MAXFLOAT))
        return sizeThatFits(textSize)
    }
}
