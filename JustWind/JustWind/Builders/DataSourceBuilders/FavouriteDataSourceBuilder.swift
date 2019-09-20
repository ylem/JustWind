import UIKit

final class FavouriteDataSourceBuilder {
    
    typealias ClearTextItem = ValueSettableCollectionItem<ClearTextCollectionViewCell>
    typealias CardItem = ValueSettableCollectionItem<FavouriteCityCollectionViewCell>
    
    private let frame: CGRect
    private let data: () -> [DisplayableWeatherCardData]?
    private let didSelectCity: (Int) -> Void

    init(frame: CGRect,
         data: @escaping () -> [DisplayableWeatherCardData]?,
         didSelectCity: @escaping (Int) -> Void) {
        self.frame = frame
        self.data = data
        self.didSelectCity = didSelectCity
    }
    
    var build: [CollectionSection] {
        return [
            GenericCollectionSection(items: [SpacerCollectionItem.clear(height: 32)]),
            emptyDataSection,
            cardSection
        ].compactMap { $0 }
    }
    
    private var emptyTextItem: CollectionItem {
        let properties = TextCellProperties(text: .emptyText,
                                            font: .medium(size: 14))
        return ClearTextItem(value: properties,
                             width: frame.widthMargin(20))
    }
    
    private var emptyDataSection: CollectionSection? {
        guard data() == nil else { return nil }
        return GenericCollectionSection(items: [
            emptyDataItem,
            SpacerCollectionItem.clear(height: 16),
            emptyTextItem
        ])
    }
    
    private var emptyDataItem: CollectionItem {
        let properties = ImageCollectionCellProperties.default(image: UIImage(imageLiteralResourceName: "empty"))
        return ValueSettableCollectionItem<ImageCollectionCell>(value: properties,
                                                                width: frame.widthMargin(20),
                                                                height: 200)
    }
    
    private var cardSection: CollectionSection? {
        guard let items = cardItems else { return nil }
        return GenericCollectionSection(items: items)
    }
    
    private var cardItems: [CollectionItem]? {
        guard let data = data() else { return nil }
        return data.reduce(into: [], { result, next in
            result?.append(SpacerCollectionItem.clear(height: 16))
            result?.append(cardItem(displayable: next))
        })
        
    }
    
    private func cardItem(displayable: DisplayableWeatherCardData) -> CollectionItem {
        let properties = FavouriteCityCollectionViewCell.Properties(city: displayable.city,
                                                                    country: displayable.country,
                                                                    windSpeed: displayable.windSpeed,
                                                                    windDegree: CGFloat(displayable.windDegree))
        return CardItem(value: properties,
                        width: frame.widthMargin(32),
                        height: 90,
                        selected: { [weak self] in
            self?.didSelectCity(displayable.cityId)
        })
    }
}

fileprivate extension String {
    
    static var emptyText: String {
        return """
        Press '+' button to add more cities
        """
    }
}
