import UIKit

public class ShowNumberButtonView: UIView {

    // MARK: - Internal properties

    private lazy var showNumberButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isAccessibilityElement = true
        button.setTitleColor(.primaryBlue, for: .normal)
        button.setTitle("Vis telefonnummer", for: .normal)
        button.addTarget(self, action: #selector(showNumberTapped), for: .touchUpInside)
        button.contentEdgeInsets = UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
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
        addSubview(showNumberButton)

        NSLayoutConstraint.activate([
            showNumberButton.topAnchor.constraint(equalTo: topAnchor),
            showNumberButton.leadingAnchor.constraint(equalTo: leadingAnchor),
            showNumberButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            showNumberButton.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }

    // MARK: - Actions

    @objc func showNumberTapped(sender: UIButton) {
        print("Show number!")
        showNumberButton.setTitle("123 45 678", for: .normal)
    }
}

