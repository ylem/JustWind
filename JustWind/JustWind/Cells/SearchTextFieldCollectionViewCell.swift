import UIKit

class SearchTextFieldCollectionViewCell: UICollectionViewCell,
                                         UITextFieldDelegate,
                                         ValueSettable {

    @IBOutlet private weak var textField: UITextField!
    
    var value: SearchTextFieldCollectionViewCell.Properties? {
        didSet {
            textField.text = value?.text
            textField.placeholder = value?.placeholder
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        textField.becomeFirstResponder()
        textField.delegate = self
    }
    
    @IBAction private func searchButtonPressed(_ sender: Any) {
        value?.didEndEditing(textField.text)
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        value?.didEndEditing(textField.text)
        return false
    }
}

extension SearchTextFieldCollectionViewCell {
    
    struct Properties {
        let text: String?
        let placeholder: String?
        let didEndEditing: (String?) -> Void
    }
}
