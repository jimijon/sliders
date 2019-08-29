import Foundation
import SwiftUI

public extension RangeSlider {
    func height(_ length: CGFloat) -> Self {
        var copy = self
        copy.height = length
        return copy
    }
    
    func thickness(_ length: CGFloat) -> Self {
        var copy = self
        copy.thickness = length
        return copy
    }
    
    func knobSize(_ size: CGSize) -> Self {
        var copy = self
        copy.knobSize = size
        return copy
    }
}

