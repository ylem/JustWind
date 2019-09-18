import XCTest
import Foundation

public func XCTAssertTrue(_ expression: @autoclosure () throws -> Bool?,
                          _ message: @autoclosure () -> String = "",
                          file: StaticString = #file,
                          line: UInt = #line) {
    var value: Bool? = nil
    do {
        value = try expression()
    }
    catch let error {
        XCTFail("Expected true, got error:- \(error.localizedDescription)", file: file, line: line)
        return
    }
    
    switch value {
    case .some(let boolValue):
        XCTAssertTrue(boolValue, file: file, line: line)
    case .none:
        XCTFail("Expected true, got nil", file: file, line: line)
    }
}
