import UIKit

extension UIImageView {
    
    func rotate(angle: CGFloat, animated: Bool = true) {
        UIView.animate(withDuration: animated ? 0.5 : 0, animations: {
            self.transform = CGAffineTransform(rotationAngle: angle)
        })
    }
    
    func rotate(degree: CGFloat, animated: Bool = true) {
        let angle = degree * CGFloat(Double.pi / 180)
        rotate(angle: angle, animated: animated)
    }
}
