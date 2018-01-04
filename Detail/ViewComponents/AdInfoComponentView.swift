import UIKit

public class AdInfoComponentView: UIView {

    // MARK: - Internal properties

    private lazy var finnCodeInfoLabel: UILabel = {
        let label = UILabel()
        label.font = .title5
        label.textColor = .stone
        label.text = "FINN-kode"
        return label
    }()

    private lazy var lastEditedInfoLabel: UILabel = {
        let label = UILabel()
        label.font = .title5
        label.textColor = .stone
        label.text = "Sist endret"
        return label
    }()

    private lazy var finnCodeContentLabel: UILabel = {
        let label = UILabel()
        label.font = .detail
        label.textColor = .stone
        label.text = "145789632"
        return label
    }()

    private lazy var lastEditedContentLabel: UILabel = {
        let label = UILabel()
        label.font = .detail
        label.textColor = .stone
        label.text = "24. nov 2017 14:04"
        return label
    }()

    private lazy var leftAdInfoStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [finnCodeInfoLabel, lastEditedInfoLabel])
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .leading
        stackView.spacing = .smallSpacing
        return stackView
    }()

    private lazy var rightAdInfoStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [finnCodeContentLabel, lastEditedContentLabel])
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .leading
        stackView.spacing = .smallSpacing
        return stackView
    }()

    private lazy var adInfoStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [leftAdInfoStackView, rightAdInfoStackView])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        stackView.spacing = .mediumSpacing
        return stackView
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
        addSubview(adInfoStackView)

        NSLayoutConstraint.activate([
            adInfoStackView.topAnchor.constraint(equalTo: topAnchor),
            adInfoStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            adInfoStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            adInfoStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }
}
