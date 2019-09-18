import Foundation

extension Bundle {
    
    static var unitTest: Bundle {
        return Bundle(for: TestAppDelegate.self)
    }
    
}
