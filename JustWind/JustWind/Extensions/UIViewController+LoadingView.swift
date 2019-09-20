import UIKit

class Spinner: UIView {

    private lazy var loadingView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        view.layer.cornerRadius = 20
        view.layer.masksToBounds = true
        view.backgroundColor = UIColor.g2.withAlphaComponent(0.8)
        let frame = UIScreen.main.bounds
        view.center = CGPoint(x: frame.width / 2, y: frame.height / 2)
        return view
    }()
    
    private lazy var indicatorView: UIView = {
        let indicator = UIActivityIndicatorView(style: .whiteLarge)
        indicator.startAnimating()
        indicator.center = CGPoint(x: 50, y: 50)
        return indicator
    }()
    
    private lazy var backgroundView: UIView = {
        let view = UIView(frame: UIScreen.main.bounds)
        view.backgroundColor = .clear
        return view
    }()
    
    func makeup() {
        loadingView.addSubview(indicatorView)
        backgroundView.addSubview(loadingView)
        self.addSubview(backgroundView)
    }
}

extension UIViewController {
    
    private var displayView: UIView {
        let rootViewController = UIApplication.shared.delegate?.window??.rootViewController
        if let nav = rootViewController as? UINavigationController {
            if let vc = nav.presentedViewController {
                return vc.view
            } else if let vc = nav.visibleViewController {
                return vc.view
            } else if let vc = nav.viewControllers.last {
                return vc.view
            }
        }
        return rootViewController?.view ?? self.view
    }
    
    func showLoading(dismissIn: TimeInterval = -1) {
        guard displayView.subviews.first(where: { $0 is Spinner }) == nil else { return }
        
        let spinner = Spinner()
        spinner.makeup()
        displayView.addSubview(spinner)
        displayView.bringSubviewToFront(spinner)

        if dismissIn > 0 {
            DispatchQueue.main.asyncAfter(deadline: .now() + dismissIn) {
                self.hideLoading()
            }
        }
    }
    
    func hideLoading() {
        displayView.subviews.first(where: { $0 is Spinner })?.removeFromSuperview()
    }
}
