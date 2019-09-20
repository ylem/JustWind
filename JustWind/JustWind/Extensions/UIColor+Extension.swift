import UIKit

extension UIColor {

    static let g1 = UIColor(hex: "161616") // 22,22,22
    static let g2 = UIColor(hex: "919191") // 145,145,145
    static let g3 = UIColor(hex: "e6e6e6")
    static let g4 = UIColor(hex: "f9f9f9")
    static let g5 = UIColor(hex: "eeeeee")
    static let blue = UIColor(hex: "00b5ff")
    static let orange = UIColor(hex: "ff8444")
    
    convenience init(hex: String, alpha: CGFloat = 1.0) {
        let scanner = Scanner(string: hex)
        scanner.scanLocation = 0
        
        var rgbValue: UInt64 = 0
        
        scanner.scanHexInt64(&rgbValue)
        
        let r = (rgbValue & 0xff0000) >> 16
        let g = (rgbValue & 0xff00) >> 8
        let b = rgbValue & 0xff
        
        self.init(
            red: CGFloat(r) / 0xff,
            green: CGFloat(g) / 0xff,
            blue: CGFloat(b) / 0xff,
            alpha: alpha
        )
    }
}
