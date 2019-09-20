import UIKit

extension UIFont {

    static func black(size: CGFloat) -> UIFont {
        return UIFont.boldSystemFont(ofSize: size)
    }
    
    static func medium(size: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: size)
    }
}
