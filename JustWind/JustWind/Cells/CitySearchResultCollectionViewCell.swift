import UIKit

class CitySearchResultCollectionViewCell: UICollectionViewCell, ValueSettable {

    @IBOutlet private weak var country: UILabel!
    @IBOutlet private weak var city: UILabel!
    @IBOutlet private weak var latLon: UILabel!
    
    var value: CitySearchResultCollectionViewCell.Properties? {
        didSet {
            city.text = value?.city
            country.text = value?.country
            latLon.text = value?.latLon
        }
    }
}

extension CitySearchResultCollectionViewCell {
    
    struct Properties {
        let city: String
        let country: String
        let latLon: String
    }
}
