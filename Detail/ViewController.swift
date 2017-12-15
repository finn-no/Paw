import UIKit

class ViewController: UIViewController {

    let mediumLargeSpacing: CGFloat = 16
    let mediumSpacing: CGFloat = 8
    let smallSpacing: CGFloat = 4
    let fontSize: CGFloat = 26
    let primaryBlue = UIColor(red: 0/255, green: 99/255, blue: 251/255, alpha: 1)
    let stone = UIColor(red: 118/255, green: 118/255, blue: 118/255, alpha: 1)
    let licorice = UIColor(red: 71/255, green: 68/255, blue: 69/255, alpha: 1)

    lazy var scrollView: UIScrollView = {
        let view = UIScrollView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    lazy var contentView: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

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
        label.textColor = licorice
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
        label.textColor = licorice
        label.text = "500,-"
        label.accessibilityLabel = "Pris: 500kroner"
        return label
    }()

    lazy var messageButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isAccessibilityElement = true
        button.setTitleColor(.white, for: .normal)
        button.setTitle("Send melding", for: .normal)
        button.contentEdgeInsets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        button.backgroundColor = primaryBlue
        button.layer.cornerRadius = 4.0
        button.addTarget(self, action: #selector(messageTapped), for: .touchUpInside)
        return button
    }()

    lazy var answerTimeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isAccessibilityElement = true
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = stone
        label.text = "Svarer vanligvis innen 4 timer"
        return label
    }()

    lazy var showNumberButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isAccessibilityElement = true
        button.setTitleColor(primaryBlue, for: .normal)
        button.setTitle("Vis telefonnummer", for: .normal)
        button.addTarget(self, action: #selector(showNumberTapped), for: .touchUpInside)
        button.contentEdgeInsets = UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        return button
    }()

    lazy var profileCellImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.image = #imageLiteral(resourceName: "profileCell")
        return imageView
    }()

    lazy var adressButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isAccessibilityElement = true
        button.setTitleColor(primaryBlue, for: .normal)
        button.setTitle("Hans Nordahls gate 64, 0841 Oslo", for: .normal)
        button.addTarget(self, action: #selector(openMapAction), for: .touchUpInside)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        let image = UIImage(imageLiteralResourceName: "pin").withRenderingMode(.alwaysTemplate)
        button.imageView?.tintColor = primaryBlue
        button.setImage(image, for: .normal)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }

    func setup() {
        view.backgroundColor = .white

        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        contentView.addSubview(galleryImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(priceLabel)
        contentView.addSubview(messageButton)
        contentView.addSubview(answerTimeLabel)
        contentView.addSubview(showNumberButton)
        contentView.addSubview(profileCellImageView)
        contentView.addSubview(adressButton)

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),

            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),

            galleryImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: mediumLargeSpacing),
            galleryImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: mediumLargeSpacing),
            galleryImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -mediumLargeSpacing),
            galleryImageView.heightAnchor.constraint(equalToConstant: 200),

            titleLabel.topAnchor.constraint(equalTo: galleryImageView.bottomAnchor, constant: mediumLargeSpacing),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: mediumLargeSpacing),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -mediumLargeSpacing),

            priceLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: mediumSpacing),
            priceLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: mediumLargeSpacing),
            priceLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -mediumLargeSpacing),

            messageButton.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: mediumLargeSpacing),
            messageButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: mediumLargeSpacing),
            messageButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -mediumLargeSpacing),

            answerTimeLabel.topAnchor.constraint(equalTo: messageButton.bottomAnchor, constant: mediumSpacing),
            answerTimeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: mediumLargeSpacing),
            answerTimeLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -mediumLargeSpacing),

            showNumberButton.topAnchor.constraint(equalTo: answerTimeLabel.bottomAnchor, constant: smallSpacing),
            showNumberButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: mediumLargeSpacing),

            profileCellImageView.topAnchor.constraint(equalTo: showNumberButton.bottomAnchor, constant: smallSpacing),
            profileCellImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: mediumLargeSpacing),
            profileCellImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -mediumLargeSpacing),
            profileCellImageView.heightAnchor.constraint(equalToConstant: 125),

            adressButton.topAnchor.constraint(equalTo: profileCellImageView.bottomAnchor, constant: mediumSpacing),
            adressButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: mediumLargeSpacing),


        ])
    }

    @objc func messageTapped(sender: UIButton) {
        print("Message sent!")
    }
    @objc func showNumberTapped(sender: UIButton) {
        print("Show number!")
    }
    @objc func openMapAction(sender: UIButton) {
        print("Opening map")
    }
    @objc func showWholeDescriptionAction(sender: UIButton) {
        descriptionLabel.numberOfLines = 0
        descriptionLabel.sizeToFit()
    }
}
