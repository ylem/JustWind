import UIKit

class ClearTextCollectionViewCell: UICollectionViewCell, ValueSettable {
    
    @IBOutlet private weak var textLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        textLabel.textAlignment = .left
    }
    
    var value: TextCellProperties? {
        didSet {
            configureTextLabel()
        }
    }
    
    private func configureTextLabel() {
        textLabel.text = value?.text
        guard let value = value else { return }
        textLabel.textAlignment = value.alignment
        textLabel.font = value.font
        textLabel.textColor = value.textColor
    }
    
}

struct TextCellProperties {
    
    let text: String?
    let alignment: NSTextAlignment
    let font: UIFont
    let textColor: UIColor
    
    init(text: String,
         font: UIFont = .medium(size: 14),
         alignment: NSTextAlignment = .center,
         textColor: UIColor = .black) {
        self.text = text
        self.font = font
        self.alignment = alignment
        self.textColor = textColor
    }
    
}
