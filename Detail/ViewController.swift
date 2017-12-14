import UIKit

class ViewController: UIViewController {

    lazy var galleryImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.image = #imageLiteral(resourceName: "sofa2")
        return imageView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }

    func setup() {
        view.backgroundColor = .white
        
        view.addSubview(galleryImageView)

        NSLayoutConstraint.activate([
            galleryImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: margin),
            galleryImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: margin),
            galleryImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -margin),
            galleryImageView.heightAnchor.constraint(equalToConstant: 200),
        ])
    }
    }
}

