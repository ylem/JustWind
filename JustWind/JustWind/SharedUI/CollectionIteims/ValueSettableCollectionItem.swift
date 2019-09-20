import UIKit

struct ValueSettableCollectionItem<T: UICollectionViewCell>: CollectionItem,
                                                             HeightGettable where T: ValueSettable {
    
    let didSelect: (() -> Void)?
    let height: CGFloat
    
    private let value: T.ValueType?
    private let width: CGFloat?
    
    init(value: T.ValueType?,
         width: CGFloat? = nil,
         height: CGFloat = 44,
         selected: (() -> Void)? = nil) {
        self.value = value
        self.width = width
        self.height = height
        self.didSelect = selected
    }
    
    func cell(collectionView: UICollectionView,
              indexPath: IndexPath) -> UICollectionViewCell {
        var cell: T = collectionView.dequeue(indexPath)
        cell.value = value
        return cell
    }
    
    func size(collectionView: UICollectionView,
              indexPath: IndexPath) -> CGSize {
        let width = self.width ?? collectionView.frame.width
        return CGSize(width: width,
                      height: height)
    }
    
}
