import UIKit

public class AdReporterView: UIView {

    // MARK: - Internal properties

    private lazy var adReporterButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isAccessibilityElement = true
        button.setTitleColor(.primaryBlue, for: .normal)
        button.setTitle("Rapporter svindel/regelbrudd", for: .normal)
        button.addTarget(self, action: #selector(adReporterTapped), for: .touchUpInside)
        button.contentEdgeInsets = UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0)
        button.titleLabel?.font = .detail
        return button
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
        addSubview(adReporterButton)

        NSLayoutConstraint.activate([
            adReporterButton.topAnchor.constraint(equalTo: topAnchor),
            adReporterButton.bottomAnchor.constraint(equalTo: bottomAnchor),
            adReporterButton.leadingAnchor.constraint(equalTo: leadingAnchor),
            adReporterButton.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }

    // MARK: - Actions

    @objc func adReporterTapped(sender: UIButton) {
        print("Reporting ad")
    }
}
