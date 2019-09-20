import XCTest

@testable import JustWind

class UserDefaults_ExtensionsTests: XCTestCase {

    func test_savedCityIds_value_isEqualToExpected() {
        let subject = MockUserDefaults()
        subject.set([1,2], forKey: "justwind_saved_city_ids")
        XCTAssertEqual(subject.savedCityIds, [1, 2])
    }
    
    func test_save_withNumber_isSavedAsExpected() {
        let subject = MockUserDefaults()
        subject.save(cityId: 1)
        let expected = subject.array(forKey: "justwind_saved_city_ids") as? [Int]
        XCTAssertEqual(expected, [1])
    }

    func test_isDuplicateId_withDuplicatedValue_returnTrue() {
        let subject = MockUserDefaults()
        subject.set([1,2], forKey: "justwind_saved_city_ids")
        XCTAssertTrue(subject.isDuplicateId(1))
    }
    
    func test_isDuplicateId_withoutDuplicatedValue_returnFalse() {
        let subject = MockUserDefaults()
        subject.set([1,2], forKey: "justwind_saved_city_ids")
        XCTAssertFalse(subject.isDuplicateId(3))
    }
}
