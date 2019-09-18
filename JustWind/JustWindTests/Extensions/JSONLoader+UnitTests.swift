import Foundation

extension JSONLoader {
    
    static func load<T>(_ fileName: String) -> T {
        return load(fileName, bundle: .unitTest)
    }
}
