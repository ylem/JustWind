import UIKit

final class CityDetailDataSourceBuilder {
    
    typealias WeatherInfoItem = ValueSettableCollectionItem<WeatherInfoCollectionViewCell>
    
    private let frame: CGRect
    private let data: CityDetailDisplayable?
    
    init(frame: CGRect,
         data: CityDetailDisplayable?) {
        self.frame = frame
        self.data = data
    }
    
    var build: [CollectionSection] {
        return [
            spaceSection,
            weatherInfoSection
        ].compactMap { $0 }
    }
    
    private var spaceSection: CollectionSection {
        return GenericCollectionSection(items: [SpacerCollectionItem.clear(height: 16)])
    }
    
    private var weatherInfoSection: CollectionSection? {
        guard let items = weatherInfoItems else { return nil }
        return GenericCollectionSection(items: items)
    }
    
    private var weatherInfoItems: [CollectionItem]? {
        guard let data = data?.forecast, !data.isEmpty else { return nil }
        return data.reduce(into: [], { result, next in
            result?.append(weatherItem(forecast: next))
            result?.append(SpacerCollectionItem.clear(height: 20))
        })

    }
    
    private func weatherItem(forecast: ForecastWeatherResponse) -> CollectionItem {
        let weatherDescription = forecast.weather.first?.description ?? ""
        let properties = WeatherInfoCollectionViewCell.Properties(date: forecast.date,
                                                                  temperature: "\(forecast.main.temp)",
                                                                  humidity: "\(forecast.main.humidity)",
                                                                  description: weatherDescription,
                                                                  weatherIconLink: forecast.weather.first?.iconLink,
                                                                  windSpeed: "\(forecast.wind.speed)",
                                                                  windDegree: CGFloat(forecast.wind.deg ?? 0))
        return WeatherInfoItem(value: properties,
                               width: frame.widthMargin(36),
                               height: 180)
    }
}
