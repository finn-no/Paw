//
//  Copyright © FINN.no AS, Inc. All rights reserved.
//

import UIKit

public enum LoadableResult {
    case success(UIImage)
    case failure(NSError)
}

public protocol Loadable {
    var url: URL? { get }
    var placeholder: UIImage { get }

    func load(_ completion: @escaping (_ result: LoadableResult) -> Void)
}
