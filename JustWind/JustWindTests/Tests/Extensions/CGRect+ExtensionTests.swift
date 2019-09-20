import XCTest

@testable import JustWind

class CGRect_ExtensionTests: XCTestCase {

    func test_widthMargin_equalToExpectedValue() {
        let subject = CGRect(x: 0, y: 0, width: 100, height: 0)
        XCTAssertEqual(subject.widthMargin(20), 60)
    }

}
