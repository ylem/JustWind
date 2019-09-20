import UIKit
import WLNetworkLayer

extension UIViewController {
    
    func handle<T>(_ response: ServiceClientResponse<T>,
                   success: ((T) -> Void)?,
                   failure: (() -> Void)? = nil) {
        switch response {
        case .success(let response):
            success?(response.object)
        case .failure(let error):
            hideLoading()
            show(error, action: failure)
        }
    }
    
    func show(_ error: ServiceClientError,
              action: (() -> Void)? = nil) {
        handleError(title: error.title,
                    message: error.message,
                    action: action)
    }
    
    
    private func handleError(title: String,
                             message: String?,
                             action: (() -> Void)? = nil) {
        show(title: title, message: message) { action?() }
    }
    
    private func show(title: String, message: String?, action: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: {_ in action?() })
        alert.addAction(okAction)
        present(alert, animated: true)
    }
}
