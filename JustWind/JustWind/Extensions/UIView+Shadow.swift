import UIKit

extension CALayer {
    
    func apply(color: UIColor = .g1,
                   opacity: Float = 0.2,
                   offset: CGSize = .zero,
                   radius: CGFloat = 1,
                   viewCornerRadius: CGFloat = 0) {
        layer.masksToBounds = false
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: viewCornerRadius).cgPath
    }
}
