import XCTest

@testable import JustWind

class ValueSettableCollectionItemTests: XCTestCase {

    private var subject: ValueSettableCollectionItem<MockValueSettableCell>!
    private var mockCollectionView: MockUICollectionView!
    
    override func setUp() {
        super.setUp()
        
        let rect = CGRect(x: 0, y: 0, width: 100, height: 122)
        mockCollectionView = MockUICollectionView(frame: rect,
                                                  collectionViewLayout: UICollectionViewFlowLayout())
        mockCollectionView._stubbedCell = MockValueSettableCell()
    }

    override func tearDown() {
        subject = nil
        mockCollectionView = nil
        super.tearDown()
    }

    func test_dequeue_withStringValue_equalExpectedValue() {
        subject = ValueSettableCollectionItem<MockValueSettableCell>(value: "test_value")
        let cell = subject.cell(collectionView: mockCollectionView, indexPath: .zero) as? MockValueSettableCell
        XCTAssertEqual(cell?.value, "test_value")
    }
    
    func test_size_withWidth_equalExpectedValue() {
        subject = ValueSettableCollectionItem<MockValueSettableCell>(value: "", width: 1)
        let size = subject.size(collectionView: mockCollectionView, indexPath: .zero)
        XCTAssertEqual(size.width, 1)
    }
    
    func test_size_withHeight_equalExpectedValue() {
        subject = ValueSettableCollectionItem<MockValueSettableCell>(value: "", height: 2)
        let size = subject.size(collectionView: mockCollectionView, indexPath: .zero)
        XCTAssertEqual(size.height, 2)
    }
}

fileprivate class MockValueSettableCell: UICollectionViewCell, ValueSettable {
    
    var value: String?
}
