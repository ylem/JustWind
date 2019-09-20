import Foundation

extension UserDefaults {
    
    private var key: String {
        return "justwind_saved_city_ids"
    }
    
    var savedCityIds: [Int]? {
        return array(forKey: key) as? [Int]
    }
    
    func save(cityId: Int) {
        guard var savedIds = array(forKey: key) else {
            return set([cityId], forKey: key)
        }
        
        savedIds.append(cityId)
        set(savedIds, forKey: key)
    }
    
    func isDuplicateId(_ id: Int) -> Bool {
        guard let savedCityIds = savedCityIds else { return false }
        return savedCityIds.contains(id)
    }
}
