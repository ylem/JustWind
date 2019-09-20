import Foundation

protocol ValueSettable {
    
    associatedtype ValueType
    
    var value: ValueType? { get set }
    
}
