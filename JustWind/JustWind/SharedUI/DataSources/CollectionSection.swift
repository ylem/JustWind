import UIKit

protocol CollectionSection {
    
    var items: [CollectionItem] { get }
    var cellCount: Int { get }
    
    func cell(collectionView: UICollectionView,
              indexPath: IndexPath) -> UICollectionViewCell
    func size(collectionView: UICollectionView, indexPath: IndexPath) -> CGSize
    func didSelect(_ collectionView: UICollectionView, indexPath: IndexPath)
    
    func headerSize(collectionView: UICollectionView) -> CGSize
    func headerView(collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionReusableView
    func footerSize(collectionView: UICollectionView) -> CGSize
    func footerView(collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionReusableView
    func shouldSelect(item: Int) -> Bool
}

extension CollectionSection {
    
    var items: [CollectionItem] {
        return []
    }
    
    var cellCount: Int {
        return items.count
    }
    
    func cell(collectionView: UICollectionView,
              indexPath: IndexPath) -> UICollectionViewCell {
        return items[indexPath.item]
            .cell(collectionView: collectionView, indexPath: indexPath)
    }
    
    func size(collectionView: UICollectionView, indexPath: IndexPath) -> CGSize {
        return items[indexPath.item]
            .size(collectionView: collectionView, indexPath: indexPath)
    }
    
    func didSelect(_ collectionView: UICollectionView, indexPath: IndexPath) {
        items[indexPath.item].didSelect?()
    }
    
    func headerSize(collectionView: UICollectionView) -> CGSize {
        return .zero
    }
    
    func headerView(collectionView: UICollectionView,
                    indexPath: IndexPath) -> UICollectionReusableView {
        return UICollectionReusableView()
    }
    
    func footerSize(collectionView: UICollectionView) -> CGSize {
        return .zero
    }
    
    func footerView(collectionView: UICollectionView,
                    indexPath: IndexPath) -> UICollectionReusableView {
        return UICollectionReusableView()
    }
    
    func shouldSelect(item: Int) -> Bool {
        return items[item].shouldSelect
    }
}
