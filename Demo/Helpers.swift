import UIKit

extension UIAlertController {
    static func dismissableAlert(title: String) -> UIAlertController {
        let controller = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        controller.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))

        return controller
    }
}
