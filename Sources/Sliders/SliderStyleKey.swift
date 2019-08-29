import SwiftUI

public struct SliderStyleKey: EnvironmentKey {
    public static let defaultValue: SliderStyle = CustomSliderStyle()
}

extension View {

    /// Sets the style for `Slider` within the environment of `self`.
    public func sliderStyle<S>(_ style: S) -> some View where S : SliderStyle {
        self.environment(\.sliderStyle, style)
    }

}

public extension EnvironmentValues {
    var sliderStyle: SliderStyle {
        get {
            return self[SliderStyleKey.self]
        }
        set {
            self[SliderStyleKey.self] = newValue
        }
    }
}

public struct SliderKnobSizeKey: EnvironmentKey {
    public static let defaultValue: CGSize = CGSize(width: 27, height: 27)
}

public extension EnvironmentValues {
    var sliderKnobSize: CGSize {
        get {
            return self[SliderKnobSizeKey.self]
        }
        set {
            self[SliderKnobSizeKey.self] = newValue
        }
    }
}
