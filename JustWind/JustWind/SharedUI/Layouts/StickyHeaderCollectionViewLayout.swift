import Foundation
import UIKit

class StickyHeaderCollectionViewLayout: UICollectionViewFlowLayout {
    
    private let stickyLayout = StretchySectionLayout()
    private var offset: CGFloat = 0
    
    override func prepare() {
        self.minimumLineSpacing = 0
        self.minimumInteritemSpacing = 0
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let attributes = super.layoutAttributesForElements(in: rect)
        return update(attributes)
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        let layout = super.layoutAttributesForItem(at: indexPath)
        return update(layout)
    }
    
    private func update(_ attributeArray: [UICollectionViewLayoutAttributes]?) -> [UICollectionViewLayoutAttributes]? {
        return attributeArray?.compactMap(update)
    }
    
    private func update(_ attributes: UICollectionViewLayoutAttributes?) -> UICollectionViewLayoutAttributes? {
        guard let collectionView = collectionView,
              let layout = attributes?.copy() as? UICollectionViewLayoutAttributes
            else { return attributes }
        return update(attributes: layout, collectionView: collectionView)
    }
    
    private func update(attributes: UICollectionViewLayoutAttributes,
                        collectionView: UICollectionView) -> UICollectionViewLayoutAttributes {
        if attributes.indexPath == .zero {
            let initial = attributes.frame.origin.y
            stickyLayout.update(layout: attributes, offset: collectionView.contentOffset)
            self.offset = attributes.frame.origin.y - initial
        }
        return attributes
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
}
