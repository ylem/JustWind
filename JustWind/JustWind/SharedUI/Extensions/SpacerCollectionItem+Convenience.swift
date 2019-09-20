import UIKit

extension SpacerCollectionItem {
    
    static func clear(height: CGFloat, color: UIColor = .clear) -> SpacerCollectionItem<SpacerCollectionViewCell> {
        return SpacerCollectionItem<SpacerCollectionViewCell>(height: height,
                                                              colour: color)
    }
    
    static var divider: SpacerCollectionItem<SpacerCollectionViewCell> {
        return SpacerCollectionItem<SpacerCollectionViewCell>(height: 1,
                                                              colour: .g3)
    }
}
