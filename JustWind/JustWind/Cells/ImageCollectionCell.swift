import UIKit

class ImageCollectionCell: UICollectionViewCell, ValueSettable {
    
    @IBOutlet private weak var imageView: UIImageView!
    
    var value: ImageCollectionCellProperties? {
        didSet {
            imageView.image = value?.image
            imageView.alpha = value?.alpha ?? 1
            imageView.contentMode = value?.contentMode ?? .scaleAspectFill
            imageView.layoutIfNeeded()
            layer.cornerRadius = value?.cornerRadius ?? 0.0
            layer.borderColor = value?.borderColor?.cgColor ?? UIColor.clear.cgColor
            layer.borderWidth = value?.borderWidth ?? 0.0
            backgroundColor = value?.backgroundColor
        }
    }
}
