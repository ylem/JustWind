import UIKit

class FavouriteCityCollectionViewCell: UICollectionViewCell, ValueSettable {
    
    @IBOutlet private weak var cityLabel: UILabel!
    @IBOutlet private weak var countryLabel: UILabel!
    @IBOutlet private weak var speedLabel: UILabel!
    @IBOutlet private weak var degreeArrowImageView: UIImageView!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.applyShadow(bounds: bounds)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = .blue
        layer.cornerRadius = 12
        degreeArrowImageView.image = UIImage(imageLiteralResourceName: "arrow").withRenderingMode(.alwaysTemplate)
        degreeArrowImageView.tintColor = .white
    }
    
    var value: FavouriteCityCollectionViewCell.Properties? {
        didSet {
            guard let value = value else { return }
            cityLabel.text = value.city
            countryLabel.text = value.country
            speedLabel.text = value.windSpeed
            degreeArrowImageView.rotate(degree: value.windDegree)
        }
    }
}

extension FavouriteCityCollectionViewCell {
    
    struct Properties {
        let city: String
        let country: String
        let windSpeed: String
        let windDegree: CGFloat
    }
}
