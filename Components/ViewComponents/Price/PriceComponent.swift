import Foundation

struct PriceComponent: Component {

    let id: String
    let price: Double

    init(id: String = UUID().uuidString, price: Double) {
        self.id = id
        self.price = price
    }
}
