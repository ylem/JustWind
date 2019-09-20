import UIKit

extension UIView {
    
    class func fromNib() -> Self {
        func loadedView<T>() -> T where T: UIView {
            return loadNib(String(describing: T.self)) as! T
        }
        return loadedView()
    }
    
    class func fromNib<T: UIView>(nibName: String) -> T {
        return loadNib(nibName) as! T
    }
    
    private class func loadNib(_ named: String,
                         owner: UIViewController? = nil,
                         bundle: Bundle? = nil) -> UIView? {
        return UINib(nibName: named, bundle: bundle)
            .instantiate(withOwner: owner, options: nil)[0] as? UIView
    }
}
