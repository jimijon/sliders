import SwiftUI

extension RangeSlider {
    /// Creates an instance that selects a range from within a range.
    ///
    /// - Parameters:
    ///     - range: The selected range within `bounds`.
    ///     - bounds: The range of the valid values. Defaults to `0...1`.
    ///     - step: The distance between each valid value. Defaults to `0.001`.
    ///     - onEditingChanged: A callback for when editing begins and ends.
    ///
    /// `onEditingChanged` will be called when editing begins and ends. For
    /// example, on iOS, a `RangeSlider` is considered to be actively editing while
    /// the user is touching the knob and sliding it around the track.
    public init(range: Binding<ClosedRange<V>>, in bounds: ClosedRange<V> = 0...1, step: V.Stride = 0.001, trackView: TrackView, valueView: ValueView, knobView: KnobView, onEditingChanged: @escaping (Bool) -> Void = { _ in }) {
        assert(range.wrappedValue.lowerBound >= bounds.lowerBound, "Range value \(range.wrappedValue) is out of bounds \(bounds)")
        assert(range.wrappedValue.upperBound <= bounds.upperBound, "Range value \(range.wrappedValue) is out of bounds \(bounds)")
        self.range = range
        self.bounds = bounds
        self.step = V(step)
        
        self.trackView = trackView
        self.valueView = valueView
        self.knobView = knobView
        
        self.onEditingChanged = onEditingChanged
    }
}

extension RangeSlider where KnobView == Capsule {
    public init(range: Binding<ClosedRange<V>>, in bounds: ClosedRange<V> = 0.0...1.0, step: V.Stride = 0.001, trackView: TrackView, valueView: ValueView, onEditingChanged: @escaping (Bool) -> Void = { _ in }) {
        self.init(range: range, in: bounds, step: step, trackView: trackView, valueView: valueView, knobView: Capsule(), onEditingChanged: onEditingChanged)
    }
}

extension RangeSlider where TrackView == Capsule {
    public init(range: Binding<ClosedRange<V>>, in bounds: ClosedRange<V> = 0.0...1.0, step: V.Stride = 0.001, valueView: ValueView, knobView: KnobView, onEditingChanged: @escaping (Bool) -> Void = { _ in }) {
        self.init(range: range, in: bounds, step: step, trackView: Capsule(), valueView: valueView, knobView: knobView, onEditingChanged: onEditingChanged)
    }
}

extension RangeSlider where TrackView == Capsule, ValueView == Rectangle {
    public init(range: Binding<ClosedRange<V>>, in bounds: ClosedRange<V> = 0.0...1.0, step: V.Stride = 0.001, knobView: KnobView, onEditingChanged: @escaping (Bool) -> Void = { _ in }) {
        self.init(range: range, in: bounds, step: step, trackView: Capsule(), valueView: Rectangle(), knobView: knobView, onEditingChanged: onEditingChanged)
    }
}

extension RangeSlider where TrackView == Capsule, KnobView == Capsule {
    public init(range: Binding<ClosedRange<V>>, in bounds: ClosedRange<V> = 0.0...1.0, step: V.Stride = 0.001, valueView: ValueView, onEditingChanged: @escaping (Bool) -> Void = { _ in }) {
        self.init(range: range, in: bounds, step: step, trackView: Capsule(), valueView: valueView, knobView: Capsule(), onEditingChanged: onEditingChanged)
    }
}

extension RangeSlider where TrackView == Capsule, ValueView == Rectangle, KnobView == Capsule {
    public init(range: Binding<ClosedRange<V>>, in bounds: ClosedRange<V> = 0.0...1.0, step: V.Stride = 0.001, onEditingChanged: @escaping (Bool) -> Void = { _ in }) {
        self.init(range: range, in: bounds, step: step, trackView: Capsule(), valueView: Rectangle(), knobView: Capsule(), onEditingChanged: onEditingChanged)
    }
}
