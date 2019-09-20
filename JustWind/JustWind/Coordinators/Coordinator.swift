import UIKit

protocol Coordinator {
    
    var presenter: UINavigationController { get set }
    
    func start()
}
