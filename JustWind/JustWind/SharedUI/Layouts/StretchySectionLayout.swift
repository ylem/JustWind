import UIKit

struct StretchySectionLayout {
    
    func update(layout: UICollectionViewLayoutAttributes,
                offset: CGPoint) {
        topFrame(layout: layout, offset: offset)
    }
    
    private func topFrame(layout: UICollectionViewLayoutAttributes,
                          offset: CGPoint) {
        if offset.y < 0 {
            extendedFrame(layout: layout, offset: offset.y)
        }
    }
    
    private func extendedFrame(layout: UICollectionViewLayoutAttributes,
                               offset: CGFloat) {
        layout.frame.origin.y = offset
        layout.frame.size.height += -offset
    }
}
