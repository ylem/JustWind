import Foundation

struct WeatherResponse: Decodable {
    
    let id: Int?
    let cod: Int?
    let dt: UInt64
    let coord: GeoCoordinator
    let weather: [Weather]
    let main: Main
    let wind: Wind
    let sys: Sys
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case cod
        case dt
        case coord
        case weather
        case main
        case wind
        case sys
        case name
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.dt = try values.decode(UInt64.self, forKey: .dt)
        self.coord = try values.decode(GeoCoordinator.self, forKey: .coord)
        self.weather = try values.decode(Array<Weather>.self, forKey: .weather)
        self.main = try values.decode(Main.self, forKey: .main)
        self.wind = try values.decode(Wind.self, forKey: .wind)
        self.sys = try values.decode(Sys.self, forKey: .sys)
        self.name = try values.decode(String.self, forKey: .name)
        
        if values.contains(.cod) {
            self.cod = try values.decode(Int.self, forKey: .cod)
        } else {
            self.cod = nil
        }
        
        if values.contains(.id) {
            self.id = try values.decode(Int.self, forKey: .id)
        } else {
            self.id = nil
        }
    }
}
