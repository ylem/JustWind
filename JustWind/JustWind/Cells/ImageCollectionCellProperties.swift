import UIKit

struct ImageCollectionCellProperties {
    let image: UIImage?
    let alpha: CGFloat?
    let contentMode: UIView.ContentMode?
    let backgroundColor: UIColor?
    let cornerRadius: CGFloat?
    let borderColor: UIColor?
    let borderWidth: CGFloat?
}

extension ImageCollectionCellProperties {
    
    static func `default`(image: UIImage?) -> ImageCollectionCellProperties {
        return .init(image: image,
                     alpha: 1.0,
                     contentMode: .scaleAspectFit,
                     backgroundColor: .clear,
                     cornerRadius: nil,
                     borderColor: nil,
                     borderWidth: nil)
    }
    
}
