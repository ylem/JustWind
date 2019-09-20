import UIKit

class WeatherInfoCollectionViewCell: UICollectionViewCell, ValueSettable {

    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var tempImageView: UIImageView!
    @IBOutlet private weak var tempValueLabel: UILabel!
    @IBOutlet private weak var humidityValueLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var windArrow: UIImageView!
    @IBOutlet private weak var windSpeedLabel: UILabel!
    
    var value: WeatherInfoCollectionViewCell.Properties? {
        didSet {
            dateLabel.text = value?.date
            tempValueLabel.text = value?.temperature
            humidityValueLabel.text = value?.humidity
            descriptionLabel.text = value?.description
            windSpeedLabel.text = value?.windSpeed
            windArrow.rotate(degree: value?.windDegree ?? 0)
            
            guard let link = value?.weatherIconLink else { return }
            tempImageView.dowload(link: link)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.applyShadow(bounds: bounds)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = .white
        layer.cornerRadius = 12
        layer.borderWidth = 1
        layer.borderColor = UIColor.blue.cgColor
    }

}

extension WeatherInfoCollectionViewCell {
    
    struct Properties {
        let date: String
        let temperature: String
        let humidity: String
        let description: String
        let weatherIconLink: String?
        let windSpeed: String
        let windDegree: CGFloat
    }
}
