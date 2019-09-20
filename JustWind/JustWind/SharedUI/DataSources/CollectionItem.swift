import UIKit

protocol CollectionItem {
    func cell(collectionView: UICollectionView,
              indexPath: IndexPath) -> UICollectionViewCell
    func size(collectionView: UICollectionView, indexPath: IndexPath) -> CGSize
    var didSelect: (() -> Void)? { get }
    var shouldSelect: Bool { get }
}

extension CollectionItem {
    
    var didSelect: (() -> Void)? {
        return nil
    }
    
    var shouldSelect: Bool {
        return didSelect != nil
    }
    
    func size(collectionView: UICollectionView,
              indexPath: IndexPath) -> CGSize {
        return .zero
    }
    
}
