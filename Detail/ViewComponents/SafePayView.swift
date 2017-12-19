import UIKit

public class SafePayView: UIView {

    // MARK: - Internal properties

    private lazy var safePayButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isAccessibilityElement = true
        button.setTitleColor(.primaryBlue, for: .normal)
        button.setTitle("FINN Trygg betaling", for: .normal)
        button.addTarget(self, action: #selector(safePayTapped), for: .touchUpInside)
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
        addSubview(safePayButton)

        NSLayoutConstraint.activate([
            safePayButton.topAnchor.constraint(equalTo: topAnchor),
            safePayButton.bottomAnchor.constraint(equalTo: bottomAnchor),
            safePayButton.leadingAnchor.constraint(equalTo: leadingAnchor),
            safePayButton.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }

    // MARK: - Actions

    @objc func safePayTapped(sender: UIButton) {
        print("Safe Pay")
    }
}

