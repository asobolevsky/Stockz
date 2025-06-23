import SwiftUI

struct Theme {
    let accent = Color(hex: "#DB2427")
    let positive = Color(hex: "#57967F")
    let negative = Color(hex: "#D02727")
    let background = Color(hex: "#FCFCFC")
    let primaryText = Color(hex: "#0D0D0D")
    let secondaryText = Color(hex: "#2A2A2A")
}

extension EnvironmentValues {
    var theme: Theme {
        get { self[ThemeKey.self] }
        set { self[ThemeKey.self] = newValue }
    }
}

private enum ThemeKey: EnvironmentKey {
    static let defaultValue: Theme = Theme()
}
