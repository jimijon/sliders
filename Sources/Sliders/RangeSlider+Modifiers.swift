import Foundation
import SwiftUI

public extension RangeSlider {
    func height(_ length: CGFloat) -> Self {
        var copy = self
        copy.height = length
        return copy
    }
}

public extension RangeSlider {
    func knobSize(_ size: CGSize) -> Self {
//        var copy = self
//        copy.styleKnobSize = size
        
        return self
    }
}

public extension ValueSlider {
    func knobSize(_ size: CGSize) -> Self {
        var copy = self
        copy.preferredKnobSize = size
        return copy
    }
}
