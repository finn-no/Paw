import UIKit

class ViewController: UIViewController {

    let margin: CGFloat = 16
    let fontSize: CGFloat = 26

    lazy var galleryImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.image = #imageLiteral(resourceName: "sofa2")
        return imageView
    }()

    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isAccessibilityElement = true
        label.font = UIFont.systemFont(ofSize: fontSize)
        label.numberOfLines = 0
        label.text = "Ny lekker sofa fra Ygg og Lybg selges til halv pris!!!"
        label.accessibilityLabel = label.text
        return label
    }()

    lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isAccessibilityElement = true
        label.font = UIFont.boldSystemFont(ofSize: fontSize)
        label.text = "500,-"
        label.accessibilityLabel = "Pris: 500kroner"
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }

    func setup() {
        view.backgroundColor = .white
        
        view.addSubview(galleryImageView)
        view.addSubview(titleLabel)
        view.addSubview(priceLabel)

        NSLayoutConstraint.activate([
            galleryImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: margin),
            galleryImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: margin),
            galleryImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -margin),
            galleryImageView.heightAnchor.constraint(equalToConstant: 200),

            titleLabel.topAnchor.constraint(equalTo: galleryImageView.bottomAnchor, constant: margin),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: margin),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -margin),

            priceLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            priceLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: margin),
            priceLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -margin),
        ])
    }
    }
}

