import UIKit

class MockUICollectionView: UICollectionView {
    
    var _stubbedCell: UICollectionViewCell = UICollectionViewCell()
    override func dequeueReusableCell(withReuseIdentifier identifier: String,
                                      for indexPath: IndexPath) -> UICollectionViewCell {
        return _stubbedCell
    }
}
