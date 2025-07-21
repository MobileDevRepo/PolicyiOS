
import UIKit

extension UIViewController {
    
    func setupNavigationBar(withTitle title: String) {
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.textColor = .white
        titleLabel.font = UIFont.boldSystemFont(ofSize: 22)
        titleLabel.textAlignment = .center
        titleLabel.sizeToFit()

        self.navigationItem.titleView = titleLabel
    }
}

extension UIColor {
    convenience init(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")
        var rgb: UInt64 = 0
        Scanner(string: hexSanitized).scanHexInt64(&rgb)

        let r = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
        let g = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
        let b = CGFloat(rgb & 0x0000FF) / 255.0

        self.init(red: r, green: g, blue: b, alpha: 1.0)
    }
}

extension Collection {
    subscript(safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}

extension UIView {
    
    func addShadowView(width:CGFloat=2, height:CGFloat=2, Opacidade:Float=0.5, maskToBounds:Bool=false, radius:CGFloat=1){
        
        self.layer.shadowColor = SystemColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: width, height: height)
        self.layer.shadowRadius = radius
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = UIScreen.main.scale
        self.layer.shadowOpacity = Opacidade
        self.layer.masksToBounds = maskToBounds
    }
}

extension UIView {
    func applyCardStyle(cornerRadius: CGFloat, borderColor: UIColor = Theme.darkGray) {
        self.addShadowView(width: 0.3, height: 0.3, Opacidade: 0.3, maskToBounds: false, radius: cornerRadius)
        self.applyStyle(cornerRadius: cornerRadius, borderWidth: 0.2, borderColor: borderColor)
    }
}

struct SystemColor {
    static let red = UIColor(red: 255/255, green: 59/255, blue: 48/255, alpha: 1)
    static let orange = UIColor(red: 255/255, green: 149/255, blue: 0/255, alpha: 1)
    static let yellow = UIColor(red: 255/255, green: 204/255, blue: 0/255, alpha: 1)
    static let green = UIColor(red: 76/255, green: 217/255, blue: 100/255, alpha: 1)
    static let tealBlue = UIColor(red: 90/255, green: 200/255, blue: 250/255, alpha: 1)
    static let blue = UIColor(red: 0/255, green: 122/255, blue: 255/255, alpha: 1)
    static let purple = UIColor(red: 88/255, green: 86/255, blue: 214/255, alpha: 1)
    static let pink = UIColor(red: 255/255, green: 45/255, blue: 85/255, alpha: 1)
    static let offwhite = UIColor(red: 240/255, green: 240/255, blue: 245/255, alpha: 1)
    static let white = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
    static let black = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1)
    static let lightGray = UIColor(red: 211/255, green: 211/255, blue: 211/255, alpha: 1)
    static let darkGray = UIColor(red: 169/255, green: 169/255, blue: 169/255, alpha: 1)
}

extension UIView {
    func applyStyle(cornerRadius: CGFloat, borderWidth: CGFloat = 0, borderColor: UIColor = .clear) {
        layer.cornerRadius = cornerRadius
        layer.borderWidth = borderWidth
        layer.borderColor = borderColor.cgColor
        layer.masksToBounds = cornerRadius > 0
    }
}
