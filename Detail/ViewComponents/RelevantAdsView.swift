import UIKit

public class RelevantAdsView: UIView {

    // MARK: - Internal properties

    private let relevantAdsImage = UIImage(named: "relevantAdsFeed")

    private lazy var relevantAdsFeedImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.isAccessibilityElement = true
        imageView.accessibilityLabel = "Relevante ting på torget."
        imageView.contentMode = .scaleAspectFit
        imageView.image = relevantAdsImage
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
        addSubview(relevantAdsFeedImageView)

        NSLayoutConstraint.activate([
            relevantAdsFeedImageView.topAnchor.constraint(equalTo: topAnchor),
            relevantAdsFeedImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            relevantAdsFeedImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            relevantAdsFeedImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }
}
