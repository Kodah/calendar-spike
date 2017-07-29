import CoreGraphics

// MARK:- hex colors

public extension Int {
    
    public var rgb: (red: CGFloat, green: CGFloat, blue: CGFloat) {
        let x = (0...0xffffff).clamp(self)
        let r = CGFloat(x >> 16 & 0xff) / 0xff
        let g = CGFloat(x >> 8  & 0xff) / 0xff
        let b = CGFloat(x       & 0xff) / 0xff
        return (r, g, b)
    }
    
    public var rgba: (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
        let x = (0...0xffffff).clamp(self)
        let r = CGFloat(x >> 24 & 0xff) / 0xff
        let g = CGFloat(x >> 16 & 0xff) / 0xff
        let b = CGFloat(x >> 8  & 0xff) / 0xff
        let a = CGFloat(x       & 0xff) / 0xff
        return (r, g, b, a)
    }
}

public extension CGColor {
    
    public static var zero: CGColor { return clear }
    public static var unit: CGColor { return black }
    public static var clear: CGColor { return .with(white: 0, alpha: 0) }
    public static var white: CGColor { return .with(white: 1) }
    
    public static func with(white: CGFloat, alpha: CGFloat = 1) -> CGColor {
        return with(red: white, green: white, blue: white, alpha: alpha)
    }
    
    public static func with(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat = 1) -> CGColor {
        return .with(components: [red, green, blue, alpha])
    }
    
    public static func with(rgb hex: Int, alpha: CGFloat = 1) -> CGColor {
        let (r, g, b) = hex.rgb
        return .with(components: [r, g, b, alpha])
    }
    
    public static func with(rgba hex: Int) -> CGColor {
        let (r, g, b, a) = hex.rgba
        return .with(components: [r, g, b, a])
    }
    
    public func with(alpha: CGFloat) -> CGColor {
        return copy(alpha: alpha) ?? .black
    }
    
    private static func with(components: [CGFloat]) -> CGColor {
        return CGColor(colorSpace: defaultSpace, components: components) ?? .black
    }
    
    private static var defaultSpace: CGColorSpace { return CGColorSpaceCreateDeviceRGB() }
}

//MARK: named colours
public extension CGColor {
    
    public static var aliceBlue: CGColor { return .with(rgb: 0xF0F8FF) }
    public static var antiqueWhite: CGColor { return .with(rgb: 0xFAEBD7) }
    public static var aqua: CGColor { return .with(rgb: 0x00FFFF) }
    public static var aquamarine: CGColor { return .with(rgb: 0x7FFFD4) }
    public static var azure: CGColor { return .with(rgb: 0xF0FFFF) }
    public static var beige: CGColor { return .with(rgb: 0xF5F5DC) }
    public static var bisque: CGColor { return .with(rgb: 0xFFE4C4) }
    public static var black: CGColor { return .with(rgb: 0x000000) }
    public static var blanchedAlmond: CGColor { return .with(rgb: 0xFFEBCD) }
    public static var blue: CGColor { return .with(rgb: 0x0000FF) }
    public static var blueViolet: CGColor { return .with(rgb: 0x8A2BE2) }
    public static var brown: CGColor { return .with(rgb: 0xA52A2A) }
    public static var burlyWood: CGColor { return .with(rgb: 0xDEB887) }
    public static var cadetBlue: CGColor { return .with(rgb: 0x5F9EA0) }
    public static var chartreuse: CGColor { return .with(rgb: 0x7FFF00) }
    public static var chocolate: CGColor { return .with(rgb: 0xD2691E) }
    public static var coral: CGColor { return .with(rgb: 0xFF7F50) }
    public static var cornflowerBlue: CGColor { return .with(rgb: 0x6495ED) }
    public static var cornsilk: CGColor { return .with(rgb: 0xFFF8DC) }
    public static var crimson: CGColor { return .with(rgb: 0xDC143C) }
    public static var cyan: CGColor { return .with(rgb: 0x00FFFF) }
    public static var darkBlue: CGColor { return .with(rgb: 0x00008B) }
    public static var darkCyan: CGColor { return .with(rgb: 0x008B8B) }
    public static var darkGoldenRod: CGColor { return .with(rgb: 0xB8860B) }
    public static var darkGray: CGColor { return .with(rgb: 0xA9A9A9) }
    public static var darkGreen: CGColor { return .with(rgb: 0x006400) }
    public static var darkKhaki: CGColor { return .with(rgb: 0xBDB76B) }
    public static var darkMagenta: CGColor { return .with(rgb: 0x8B008B) }
    public static var darkOliveGreen: CGColor { return .with(rgb: 0x556B2F) }
    public static var darkOrange: CGColor { return .with(rgb: 0xFF8C00) }
    public static var darkOrchid: CGColor { return .with(rgb: 0x9932CC) }
    public static var darkRed: CGColor { return .with(rgb: 0x8B0000) }
    public static var darkSalmon: CGColor { return .with(rgb: 0xE9967A) }
    public static var darkSeaGreen: CGColor { return .with(rgb: 0x8FBC8F) }
    public static var darkSlateBlue: CGColor { return .with(rgb: 0x483D8B) }
    public static var darkSlateGray: CGColor { return .with(rgb: 0x2F4F4F) }
    public static var darkTurquoise: CGColor { return .with(rgb: 0x00CED1) }
    public static var darkViolet: CGColor { return .with(rgb: 0x9400D3) }
    public static var deepPink: CGColor { return .with(rgb: 0xFF1493) }
    public static var deepSkyBlue: CGColor { return .with(rgb: 0x00BFFF) }
    public static var dimGray: CGColor { return .with(rgb: 0x696969) }
    public static var dodgerBlue: CGColor { return .with(rgb: 0x1E90FF) }
    public static var fireBrick: CGColor { return .with(rgb: 0xB22222) }
    public static var floralWhite: CGColor { return .with(rgb: 0xFFFAF0) }
    public static var forestGreen: CGColor { return .with(rgb: 0x228B22) }
    public static var fuchsia: CGColor { return .with(rgb: 0xFF00FF) }
    public static var gainsboro: CGColor { return .with(rgb: 0xDCDCDC) }
    public static var ghostWhite: CGColor { return .with(rgb: 0xF8F8FF) }
    public static var gold: CGColor { return .with(rgb: 0xFFD700) }
    public static var goldenRod: CGColor { return .with(rgb: 0xDAA520) }
    public static var gray: CGColor { return .with(rgb: 0x808080) }
    public static var green: CGColor { return .with(rgb: 0x008000) }
    public static var greenYellow: CGColor { return .with(rgb: 0xADFF2F) }
    public static var honeyDew: CGColor { return .with(rgb: 0xF0FFF0) }
    public static var hotPink: CGColor { return .with(rgb: 0xFF69B4) }
    public static var indianRed: CGColor { return .with(rgb: 0xCD5C5C) }
    public static var indigo: CGColor { return .with(rgb: 0x4B0082) }
    public static var ivory: CGColor { return .with(rgb: 0xFFFFF0) }
    public static var khaki: CGColor { return .with(rgb: 0xF0E68C) }
    public static var lavender: CGColor { return .with(rgb: 0xE6E6FA) }
    public static var lavenderBlush: CGColor { return .with(rgb: 0xFFF0F5) }
    public static var lawnGreen: CGColor { return .with(rgb: 0x7CFC00) }
    public static var lemonChiffon: CGColor { return .with(rgb: 0xFFFACD) }
    public static var lightBlue: CGColor { return .with(rgb: 0xADD8E6) }
    public static var lightCoral: CGColor { return .with(rgb: 0xF08080) }
    public static var lightCyan: CGColor { return .with(rgb: 0xE0FFFF) }
    public static var lightGoldenRodYellow: CGColor { return .with(rgb: 0xFAFAD2) }
    public static var lightGray: CGColor { return .with(rgb: 0xD3D3D3) }
    public static var lightGreen: CGColor { return .with(rgb: 0x90EE90) }
    public static var lightPink: CGColor { return .with(rgb: 0xFFB6C1) }
    public static var lightSalmon: CGColor { return .with(rgb: 0xFFA07A) }
    public static var lightSeaGreen: CGColor { return .with(rgb: 0x20B2AA) }
    public static var lightSkyBlue: CGColor { return .with(rgb: 0x87CEFA) }
    public static var lightSlateGray: CGColor { return .with(rgb: 0x778899) }
    public static var lightSteelBlue: CGColor { return .with(rgb: 0xB0C4DE) }
    public static var lightYellow: CGColor { return .with(rgb: 0xFFFFE0) }
    public static var lime: CGColor { return .with(rgb: 0x00FF00) }
    public static var limeGreen: CGColor { return .with(rgb: 0x32CD32) }
    public static var linen: CGColor { return .with(rgb: 0xFAF0E6) }
    public static var magenta: CGColor { return .with(rgb: 0xFF00FF) }
    public static var maroon: CGColor { return .with(rgb: 0x800000) }
    public static var mediumAquaMarine: CGColor { return .with(rgb: 0x66CDAA) }
    public static var mediumBlue: CGColor { return .with(rgb: 0x0000CD) }
    public static var mediumOrchid: CGColor { return .with(rgb: 0xBA55D3) }
    public static var mediumPurple: CGColor { return .with(rgb: 0x9370DB) }
    public static var mediumSeaGreen: CGColor { return .with(rgb: 0x3CB371) }
    public static var mediumSlateBlue: CGColor { return .with(rgb: 0x7B68EE) }
    public static var mediumSpringGreen: CGColor { return .with(rgb: 0x00FA9A) }
    public static var mediumTurquoise: CGColor { return .with(rgb: 0x48D1CC) }
    public static var mediumVioletRed: CGColor { return .with(rgb: 0xC71585) }
    public static var midnightBlue: CGColor { return .with(rgb: 0x191970) }
    public static var mintCream: CGColor { return .with(rgb: 0xF5FFFA) }
    public static var mistyRose: CGColor { return .with(rgb: 0xFFE4E1) }
    public static var moccasin: CGColor { return .with(rgb: 0xFFE4B5) }
    public static var navajoWhite: CGColor { return .with(rgb: 0xFFDEAD) }
    public static var navy: CGColor { return .with(rgb: 0x000080) }
    public static var oldLace: CGColor { return .with(rgb: 0xFDF5E6) }
    public static var olive: CGColor { return .with(rgb: 0x808000) }
    public static var oliveDrab: CGColor { return .with(rgb: 0x6B8E23) }
    public static var orange: CGColor { return .with(rgb: 0xFFA500) }
    public static var orangeRed: CGColor { return .with(rgb: 0xFF4500) }
    public static var orchid: CGColor { return .with(rgb: 0xDA70D6) }
    public static var paleGoldenRod: CGColor { return .with(rgb: 0xEEE8AA) }
    public static var paleGreen: CGColor { return .with(rgb: 0x98FB98) }
    public static var paleTurquoise: CGColor { return .with(rgb: 0xAFEEEE) }
    public static var paleVioletRed: CGColor { return .with(rgb: 0xDB7093) }
    public static var papayaWhip: CGColor { return .with(rgb: 0xFFEFD5) }
    public static var peachPuff: CGColor { return .with(rgb: 0xFFDAB9) }
    public static var peru: CGColor { return .with(rgb: 0xCD853F) }
    public static var pink: CGColor { return .with(rgb: 0xFFC0CB) }
    public static var plum: CGColor { return .with(rgb: 0xDDA0DD) }
    public static var powderBlue: CGColor { return .with(rgb: 0xB0E0E6) }
    public static var purple: CGColor { return .with(rgb: 0x800080) }
    public static var rebeccaPurple: CGColor { return .with(rgb: 0x663399) }
    public static var red: CGColor { return .with(rgb: 0xFF0000) }
    public static var rosyBrown: CGColor { return .with(rgb: 0xBC8F8F) }
    public static var royalBlue: CGColor { return .with(rgb: 0x4169E1) }
    public static var saddleBrown: CGColor { return .with(rgb: 0x8B4513) }
    public static var salmon: CGColor { return .with(rgb: 0xFA8072) }
    public static var sandyBrown: CGColor { return .with(rgb: 0xF4A460) }
    public static var seaGreen: CGColor { return .with(rgb: 0x2E8B57) }
    public static var seaShell: CGColor { return .with(rgb: 0xFFF5EE) }
    public static var sienna: CGColor { return .with(rgb: 0xA0522D) }
    public static var silver: CGColor { return .with(rgb: 0xC0C0C0) }
    public static var skyBlue: CGColor { return .with(rgb: 0x87CEEB) }
    public static var slateBlue: CGColor { return .with(rgb: 0x6A5ACD) }
    public static var slateGray: CGColor { return .with(rgb: 0x708090) }
    public static var snow: CGColor { return .with(rgb: 0xFFFAFA) }
    public static var springGreen: CGColor { return .with(rgb: 0x00FF7F) }
    public static var steelBlue: CGColor { return .with(rgb: 0x4682B4) }
    public static var tan: CGColor { return .with(rgb: 0xD2B48C) }
    public static var teal: CGColor { return .with(rgb: 0x008080) }
    public static var thistle: CGColor { return .with(rgb: 0xD8BFD8) }
    public static var tomato: CGColor { return .with(rgb: 0xFF6347) }
    public static var turquoise: CGColor { return .with(rgb: 0x40E0D0) }
    public static var violet: CGColor { return .with(rgb: 0xEE82EE) }
    public static var wheat: CGColor { return .with(rgb: 0xF5DEB3) }
    public static var wc1hite: CGColor { return .with(rgb: 0xFFFFFF) }
    public static var whiteSmoke: CGColor { return .with(rgb: 0xF5F5F5) }
    public static var yellow: CGColor { return .with(rgb: 0xFFFF00) }
    public static var yellowGreen: CGColor { return .with(rgb: 0x9ACD32) }
}

