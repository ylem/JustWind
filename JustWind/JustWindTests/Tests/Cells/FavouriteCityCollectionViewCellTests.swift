import XCTest

@testable import JustWind

class FavouriteCityCollectionViewCellTests: XCTestCase {

    private var subject: FavouriteCityCollectionViewCell!
    private var cityLabel: UILabel!
    private var countryLabel: UILabel!
    private var speedLabel: UILabel!
    private var degreeArrowImageView: UIImageView!
    
    override func setUp() {
        super.setUp()
        subject = .fromNib()
        cityLabel = UILabel()
        countryLabel = UILabel()
        speedLabel = UILabel()
        degreeArrowImageView = UIImageView()
        
        subject.setValue(cityLabel, forKey: "cityLabel")
        subject.setValue(countryLabel, forKey: "countryLabel")
        subject.setValue(speedLabel, forKey: "speedLabel")
        subject.setValue(degreeArrowImageView, forKey: "degreeArrowImageView")
        
        let properties = FavouriteCityCollectionViewCell.Properties(city: "Leeds",
                                                                    country: "UK",
                                                                    windSpeed: "5.0",
                                                                    windDegree: 45.0)
        subject.value = properties
    }

    override func tearDown() {
        subject = nil
        cityLabel = nil
        countryLabel = nil
        speedLabel = nil
        degreeArrowImageView = nil
        super.tearDown()
    }

    func test_cityLabel_text_isEqualToExpected() {
        XCTAssertEqual(cityLabel.text, "Leeds")
    }
    
    func test_countryLabel_text_isEqualToExpected() {
        XCTAssertEqual(countryLabel.text, "UK")
    }
    
    func test_speedLabel_text_isEqualToExpected() {
        XCTAssertEqual(speedLabel.text, "5.0")
    }
}
