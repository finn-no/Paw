import UIKit

public class CollapsableDescriptionComponentView: UIView {

    // MARK: - Internal properties

    private let maximumNumberOfLines = 5
    private let descriptionText = "Selger min bestemors gamle sykkel. Den er godt brukt, fungerer godt. Jeg har byttet slange, men latt være å gjøre noe mer på den. Du som kjøper den kan fikse den opp akkurat som du vil ha den :) Jeg ville aldri kjøpt den, men jeg satser på at du er dum nok til å bare gå for det. God jul og lykke til!"

    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 5
        label.font = .body
        label.textColor = .stone
        label.text = descriptionText
        return label
    }()

    private lazy var showWholeDescriptionButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isAccessibilityElement = true
        button.setTitleColor(.primaryBlue, for: .normal)
        button.setTitle("+ Vis hele beskrivelsen", for: .normal)
        button.addTarget(self, action: #selector(showWholeDescriptionAction), for: .touchUpInside)
        button.contentEdgeInsets = UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0)
        button.titleLabel?.font = .title4
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
        addSubview(descriptionLabel)
        addSubview(showWholeDescriptionButton)

        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: topAnchor),
            descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor),

            showWholeDescriptionButton.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: .mediumSpacing),
            showWholeDescriptionButton.leadingAnchor.constraint(equalTo: leadingAnchor),
            showWholeDescriptionButton.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor),
            showWholeDescriptionButton.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }

    // MARK: - Actions

    @objc private func showWholeDescriptionAction(sender: UIButton) {
        if descriptionLabel.numberOfLines >= maximumNumberOfLines {
            print("Vis hele beskrivelsen!")
            UIView.animate(withDuration: 0.2, delay: 0.0, options: .curveEaseInOut, animations: {
                self.showWholeDescriptionButton.setTitle("- Vis mindre", for: .normal)
                self.descriptionLabel.numberOfLines = 0
                self.descriptionLabel.sizeToFit()
            }, completion: nil)
        } else {
            print("Vis mindre av beskrivelsen!")
            UIView.animate(withDuration: 0.2, delay: 0.0, options: .curveEaseInOut, animations: {
                self.showWholeDescriptionButton.setTitle("+ Vis hele beskrivelsen", for: .normal)
                self.descriptionLabel.numberOfLines = self.maximumNumberOfLines
                self.descriptionLabel.sizeToFit()
            }, completion: nil)
        }
    }
}

