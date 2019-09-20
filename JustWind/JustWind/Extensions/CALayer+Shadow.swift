import UIKit

extension CALayer {
    
    func applyShadow(color: UIColor = .g1,
                     alpha: Float = 0.2,
                     xOffset: CGFloat = 0,
                     yOffset: CGFloat = 12,
                     blur: CGFloat = 12,
                     bounds: CGRect) {
        shadowColor = color.cgColor
        shadowOpacity = alpha
        shadowOffset = CGSize(width: xOffset, height: yOffset)
        shadowRadius = blur / 2.0
        masksToBounds = false
        shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: yOffset).cgPath
    }
}
