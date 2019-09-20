import UIKit

final class FavouriteDataSourceBuilder {
    
    typealias ClearTextItem = ValueSettableCollectionItem<ClearTextCollectionViewCell>
    
    private let frame: CGRect
    
    init(frame: CGRect) {
        self.frame = frame
    }
    
    var build: [CollectionSection] {
        return [
            titleSection
        ]
    }
    
    private var titleSection: CollectionSection {
        return GenericCollectionSection(items: [
            SpacerCollectionItem.clear(height: 16),
            titleItem
        ])
    }
    
    private var titleItem: CollectionItem {
        let properties = TextCellProperties(text: "Just Wind", font: .black(size: 24.0))
        return ClearTextItem(value: properties,
                             width: frame.widthMargin(20))
    }
}
