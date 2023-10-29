import Foundation
import UIKit

struct AppFontName {
    static let thin = "PublicSans-Thin"
    static let light = "PublicSans-Light"
    static let regular = "PublicSans-Regular"
    static let medium = "PublicSans-Medium"
    static let semiBold = "PublicSans-SemiBold"
    static let bold = "PublicSans-Bold"
    static let black = "PublicSans-Black"
    static let extraBold = "PublicSans-ExtraBold"
    static let italic = "PublicSans-Italic"
}

extension UIFont {

    @objc class func customSystemFont(ofSize size: CGFloat) -> UIFont {
        UIFont(name: AppFontName.regular, size: size)!
    }

    @objc class func customBoldSystemFont(ofSize size: CGFloat) -> UIFont {
        UIFont(name: AppFontName.bold, size: size)!
    }

    @objc class func customItalicSystemFont(ofSize size: CGFloat) -> UIFont {
        UIFont(name: AppFontName.italic, size: size)!
    }

    @objc convenience init(customCoder aDecoder: NSCoder) {
        if let fontDescriptor = aDecoder.decodeObject(forKey: "UIFontDescriptor") as? UIFontDescriptor {
            if let fontAttribute = fontDescriptor.fontAttributes[UIFontDescriptor.AttributeName.textStyle] as? String {
                var fontName = ""
                switch fontAttribute {
                case "CTFontThinUsage", "CTFontUltraLightUsage":
                    fontName = AppFontName.thin
                case "CTFontLightUsage":
                    fontName = AppFontName.light
                case "CTFontRegularUsage":
                    fontName = AppFontName.regular
                case "CTFontMediumUsage":
                    fontName = AppFontName.medium
                case "CTFontSemiBoldUsage":
                    fontName = AppFontName.semiBold
                case "CTFontEmphasizedUsage", "CTFontBoldUsage":
                    fontName = AppFontName.bold
                case "CTFontHeavyUsage", "CTFontBlackUsage":
                    fontName = AppFontName.extraBold
                case "CTFontObliqueUsage":
                    fontName = AppFontName.italic
                default:
                    fontName = AppFontName.regular
                }
                self.init(name: fontName, size: fontDescriptor.pointSize)!
            } else {
                self.init(customCoder: aDecoder)
            }
        } else {
            self.init(customCoder: aDecoder)
        }
    }

    @objc class func customSystemFont(ofSize size: CGFloat, weight: Weight) -> UIFont {
        var fontName = ""
        switch weight {
        case .thin, .ultraLight:
            fontName = AppFontName.thin
        case .light:
            fontName = AppFontName.light
        case .regular:
            fontName = AppFontName.regular
        case .medium:
            fontName = AppFontName.medium
        case .semibold:
            fontName = AppFontName.semiBold
        case .bold:
            fontName = AppFontName.bold
        case .black:
            fontName = AppFontName.bold
        case .heavy:
            fontName = AppFontName.extraBold
        default:
            fontName = AppFontName.regular
        }
        return self.init(name: fontName, size: size)!
    }

    class func overrideInitialize() {
        if self == UIFont.self {
            let systemFontMethod = class_getClassMethod(self, #selector(systemFont(ofSize:)))
            let customSystemFontMethod = class_getClassMethod(self, #selector(customSystemFont(ofSize:)))
            method_exchangeImplementations(systemFontMethod!, customSystemFontMethod!)

            let boldSystemFontMethod = class_getClassMethod(self, #selector(boldSystemFont(ofSize:)))
            let customBoldSystemFontMethod = class_getClassMethod(self, #selector(customBoldSystemFont(ofSize:)))
            method_exchangeImplementations(boldSystemFontMethod!, customBoldSystemFontMethod!)

            let italicSystemFontMethod = class_getClassMethod(self, #selector(italicSystemFont(ofSize:)))
            let customItalicSystemFontMethod = class_getClassMethod(self, #selector(customItalicSystemFont(ofSize:)))
            method_exchangeImplementations(italicSystemFontMethod!, customItalicSystemFontMethod!)

            let initCoderMethod = class_getInstanceMethod(self, #selector(UIFontDescriptor.init(coder:)))
            let customInitCoderMethod = class_getInstanceMethod(self, #selector(UIFont.init(customCoder:)))
            method_exchangeImplementations(initCoderMethod!, customInitCoderMethod!)

            let systemFontWeightMethod = class_getClassMethod(self, #selector(systemFont(ofSize:weight:)))
            let customSystemFontWeightMethod = class_getClassMethod(self, #selector(customSystemFont(ofSize:weight:)))
            method_exchangeImplementations(systemFontWeightMethod!, customSystemFontWeightMethod!)
        }
    }

    func withTraits(traits: UIFontDescriptor.SymbolicTraits) -> UIFont {
        let descriptor = fontDescriptor.withSymbolicTraits(traits)
        return UIFont(descriptor: descriptor!, size: 0) // size 0 means keep the size as it is
    }

    func bold() -> UIFont {
        withTraits(traits: .traitBold)
    }

    func italic() -> UIFont {
        withTraits(traits: .traitItalic)
    }

}

