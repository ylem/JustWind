import UIKit

extension CGRect {
    
    func widthMargin(_ margin: CGFloat) -> CGFloat {
        return width - (margin * 2)
    }
}
