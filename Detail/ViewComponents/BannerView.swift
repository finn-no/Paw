import UIKit

public class BannerView: UIView {

    // MARK: - Internal properties

    private let bannerImage = UIImage(named: "adCell")

    private lazy var adCellImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.isAccessibilityElement = true
        imageView.accessibilityLabel = "Reklame"
        imageView.contentMode = .scaleAspectFit
        imageView.image = bannerImage
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
        addSubview(adCellImageView)

        NSLayoutConstraint.activate([
            adCellImageView.topAnchor.constraint(equalTo: topAnchor),
            adCellImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            adCellImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            adCellImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }
}
