import Foundation

public func XCTPass(file: StaticString = #file, line: UInt = #line) {
    
    XCTAssertTrue(true, file: file, line: line)
    
}
