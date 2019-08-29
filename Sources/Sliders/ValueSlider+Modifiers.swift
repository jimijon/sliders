import Foundation
import SwiftUI

public extension ValueSlider {
    func height(_ length: CGFloat) -> Self {
        var copy = self
        copy.height = length
        return copy
    }
}
