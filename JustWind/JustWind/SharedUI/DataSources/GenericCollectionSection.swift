import UIKit

struct GenericCollectionSection: CollectionSection, HeightGettable {
    
    let items: [CollectionItem]
    
    init(items: [CollectionItem]) {
        self.items = items
    }
    
    var height: CGFloat {
        let itemsHeights = items.compactMap { $0 as? HeightGettable }
        return itemsHeights.map({ $0.height }).reduce(0, +)
    }
    
}
