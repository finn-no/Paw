import UIKit

public class GalleryView: UIView {
    
    // MARK: - Internal properties

    private let sofaImage = #imageLiteral(resourceName: "sofa2")

    private lazy var galleryImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.isAccessibilityElement = true
        imageView.accessibilityLabel = "Bilde: rosa sofa. Mørkt tregulv. Bilde 1 av 23."
        imageView.contentMode = .scaleAspectFit
        imageView.image = sofaImage
        return imageView
    }()

    // MARK: - Setup

    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    private func setup() {
        addSubview(galleryImageView)

        NSLayoutConstraint.activate([
            galleryImageView.topAnchor.constraint(equalTo: topAnchor),
            galleryImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            galleryImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            galleryImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }
}
