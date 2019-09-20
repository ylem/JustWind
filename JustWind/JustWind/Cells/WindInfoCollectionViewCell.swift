import UIKit

class WindInfoCollectionViewCell: UICollectionViewCell, ValueSettable {

    @IBOutlet private weak var speedLabel: UILabel!
    @IBOutlet private weak var arrowImageView: UIImageView!
    @IBOutlet private weak var degreeInfoLabel: UILabel!
    
    var value: WindInfoCollectionViewCell.Properties? {
        didSet {
            guard let value = value else { return }
            speedLabel.text = "\(value.speed) \(value.units)"
            degreeInfoLabel.text = value.degreeDescriptin
            arrowImageView.rotate(degree: CGFloat(value.degree))
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.applyShadow(bounds: bounds)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = UIColor.cyan.withAlphaComponent(0.6)
        layer.cornerRadius = 12
    }
}

extension WindInfoCollectionViewCell {
    
    struct Properties {
        let speed: String
        let units: String
        let degree: Double
        
        var degreeDescriptin: String {
            if degree < 90 {
                return "North (\(degree))"
            } else if degree < 180 {
                return "East (\(degree))"
            } else if degree < 270 {
                return "South \(degree)"
            } else {
                return "West \(degree)"
            }
        }
    }
}
