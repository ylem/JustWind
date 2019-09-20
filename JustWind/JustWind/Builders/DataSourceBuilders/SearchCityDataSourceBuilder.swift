import UIKit

final class SearchCityDataSourceBuilder {
    
    typealias ClearTextItem = ValueSettableCollectionItem<ClearTextCollectionViewCell>
    
    private let frame: CGRect
    private let data: () -> [City]?
    private let didEndEditing: (String?) -> Void
    private let didSelectCity: (City) -> Void
    
    init(frame: CGRect,
         data: @escaping () -> [City]?,
         didEndEditing: @escaping (String?) -> Void,
         didSelectCity: @escaping (City) -> Void) {
        self.frame = frame
        self.data = data
        self.didEndEditing = didEndEditing
        self.didSelectCity = didSelectCity
    }
    
    var build: [CollectionSection] {
        return [
            topSection,
            emptyDataSection,
            searchResultSection
        ].compactMap { $0 }
    }
    
    private var topSection: CollectionSection {
        return GenericCollectionSection(items: [
            SpacerCollectionItem.divider,
            seachItem,
        ])
    }
    
    private var seachItem: CollectionItem {
        let properties = SearchTextFieldCollectionViewCell.Properties(text: nil,
                                                     placeholder: "Search city",
                                                     didEndEditing: didEndEditing)
        return ValueSettableCollectionItem<SearchTextFieldCollectionViewCell>(value: properties,
                                                                              width: frame.widthMargin(20),
                                                                              height: 90)
    }
    
    private var searchResultSection: CollectionSection? {
        guard let items = searchResultItems else { return nil }
        return GenericCollectionSection(items: items)
    }

    private var searchResultItems: [CollectionItem]? {
        guard let data = data() else { return nil }
        return data.reduce(into: [], { result, next in
            result?.append(resultItem(city: next))
            result?.append(SpacerCollectionItem.divider(width: frame.widthMargin(32)))
            result?.append(SpacerCollectionItem.clear(height: 16))
        })
    }
    
    private func resultItem(city: City) -> CollectionItem {
        let properties = CitySearchResultCollectionViewCell.Properties(city: city.name,
                                                                       country:  city.sys.country,
                                                                       latLon: city.coord.description)
        return ValueSettableCollectionItem<CitySearchResultCollectionViewCell>(value: properties,
                                                                               width: frame.widthMargin(32),
                                                                               height: 56,
                                                                               selected: {
            [weak self] in
            self?.didSelectCity(city)
        })
    }

    private var emptyDataItem: CollectionItem {
        let properties = ImageCollectionCellProperties.default(image: UIImage(imageLiteralResourceName: "empty"))
        return ValueSettableCollectionItem<ImageCollectionCell>(value: properties,
                                                                width: frame.widthMargin(20),
                                                                height: 200)
    }
    
    private var emptyTextItem: CollectionItem {
        let properties = TextCellProperties(text: .emptyText,
                                            font: .medium(size: 14))
        return ClearTextItem(value: properties,
                             width: frame.widthMargin(20))
    }
    
    private var emptyDataSection: CollectionSection? {
        guard isEmptyData else { return nil }
        return GenericCollectionSection(items: [
            emptyDataItem,
            SpacerCollectionItem.clear(height: 16),
            emptyTextItem
        ])
    }

    private var isEmptyData: Bool {
        return data() == nil || (data()?.isEmpty ?? true)
    }
}

fileprivate extension String {
    
    static var emptyText: String {
        return """
        No cities found
        """
    }
}
