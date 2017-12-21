import UIKit

protocol ObjectViewDataSource: class {

}

protocol ObjectViewDelegate: class {

}

class ObjectView: UIView {
    weak var dataSource: ObjectViewDataSource?
    weak var delegate: ObjectViewDelegate?

    lazy var scrollView: UIScrollView = {
        return UIScrollView()
    }()
}
