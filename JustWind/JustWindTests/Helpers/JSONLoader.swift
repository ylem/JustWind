import Foundation

struct JSONLoader {
    
    static func load<T>(_ fileName: String,
                        bundle: Bundle,
                        directory: String? = nil) -> T {
        let filePath = bundle.path(forResource: fileName,
                                   ofType: "json",
                                   inDirectory: directory)!
        let data = try! Data(contentsOf: URL(fileURLWithPath: filePath))
        return try! JSONSerialization.jsonObject(with: data,
                                                 options: .allowFragments) as! T
    }
}
