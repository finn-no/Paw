import UIKit

public class DeliveryHelpView: UIView {

    // MARK: - Internal properties

    private let deliveryHelpImage = UIImage(named: "deliveryHelp")

    private lazy var deliveryHelpImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.isAccessibilityElement = true
        imageView.accessibilityLabel = "Knapp: Få hjelp til frakt."
        imageView.contentMode = .scaleAspectFit
        imageView.image = deliveryHelpImage
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
        addSubview(deliveryHelpImageView)

        NSLayoutConstraint.activate([
            deliveryHelpImageView.topAnchor.constraint(equalTo: topAnchor),
            deliveryHelpImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            deliveryHelpImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            deliveryHelpImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }
}
