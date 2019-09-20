import Foundation

class MockUserDefaults: UserDefaults {
    
    var anyDefaults: [String: Any] = [:]
    
    override func set(_ value: Any?, forKey defaultName: String) {
        anyDefaults[defaultName] = value
    }
    
    override func value(forKey key: String) -> Any? {
        return anyDefaults[key]
    }
    
    override func array(forKey defaultName: String) -> [Any]? {
        return anyDefaults[defaultName] as? [Any]
    }
}
