import UIKit

class SpacerCollectionItem<T: UICollectionViewCell>: CollectionItem, HeightGettable {
    
    let height: CGFloat
    let width: CGFloat?
    private let colour: UIColor
    
    init(height: CGFloat,
         width: CGFloat? = nil,
         colour: UIColor) {
        self.height = height
        self.width = width
        self.colour = colour
    }
    
    func cell(collectionView: UICollectionView,
              indexPath: IndexPath) -> UICollectionViewCell {
        let cell: T = collectionView.dequeue(indexPath)
        cell.backgroundColor = colour
        return cell
    }
    
    func size(collectionView: UICollectionView,
              indexPath: IndexPath) -> CGSize {
        return CGSize(width: width ?? collectionView.frame.width,
                      height: height)
    }
    
}
