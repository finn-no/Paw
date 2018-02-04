//
//  Copyright © FINN.no AS, Inc. All rights reserved.
//

import Smash

struct Image: Loadable {
    var stringURL: String?
    var placeholder: UIImage

    init(stringURL: String?, placeholder: UIImage) {
        self.stringURL = stringURL
        self.placeholder = placeholder
    }

    func load(_ completion: @escaping (_ result: LoadableResult) -> Void) {
        guard let stringURL = self.stringURL else { return }
        guard let url = URL(string: stringURL) else { return }

        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(LoadableResult.failure(error as NSError))
            } else {
                DispatchQueue.main.async {
                    if let data = data, let image = UIImage(data: data) {
                        completion(LoadableResult.success(image))
                    } else {
                        completion(LoadableResult.failure(NSError(domain: "error", code: 404, userInfo: nil)))
                    }
                }
            }
        }.resume()
    }
}
