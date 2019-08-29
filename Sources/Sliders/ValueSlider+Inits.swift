import SwiftUI

extension ValueSlider {
    /// Creates an instance that selects a value from within a range.
    ///
    /// - Parameters:
    ///     - value: The selected value within `bounds`.
    ///     - bounds: The range of the valid values. Defaults to `0...1`.
    ///     - onEditingChanged: A callback for when editing begins and ends.
    ///
    /// `onEditingChanged` will be called when editing begins and ends. For
    /// example, on iOS, a `RangeSlider` is considered to be actively editing while
    /// the user is touching the knob and sliding it around the track.
    public init(value: Binding<V>, in bounds: ClosedRange<V> = 0.0...1.0, step: V.Stride = 0.001, trackView: TrackView, valueView: ValueView, knobView: KnobView, onEditingChanged: @escaping (Bool) -> Void = { _ in }) {
        assert(value.wrappedValue >= bounds.lowerBound, "Value \(value.wrappedValue) is out of bounds \(bounds)")
        assert(value.wrappedValue <= bounds.upperBound, "Value \(value.wrappedValue) is out of bounds \(bounds)")
        self.value = value
        self.bounds = bounds
        self.step = V(step)
        
        self.trackView = trackView
        self.valueView = valueView
        self.knobView = knobView
        
        self.onEditingChanged = onEditingChanged
    }
}

extension ValueSlider where KnobView == Rectangle {
    public init(value: Binding<V>, in bounds: ClosedRange<V> = 0.0...1.0, step: V.Stride = 0.001, trackView: TrackView, valueView: ValueView, onEditingChanged: @escaping (Bool) -> Void = { _ in }) {
        self.init(value: value, in: bounds, step: step, trackView: trackView, valueView: valueView, knobView: Rectangle(), onEditingChanged: onEditingChanged)
    }
}

extension ValueSlider where TrackView == Rectangle {
    public init(value: Binding<V>, in bounds: ClosedRange<V> = 0.0...1.0, step: V.Stride = 0.001, valueView: ValueView, knobView: KnobView, onEditingChanged: @escaping (Bool) -> Void = { _ in }) {
        self.init(value: value, in: bounds, step: step, trackView: Rectangle(), valueView: valueView, knobView: knobView, onEditingChanged: onEditingChanged)
    }
}

extension ValueSlider where TrackView == Rectangle, ValueView == Rectangle{
    public init(value: Binding<V>, in bounds: ClosedRange<V> = 0.0...1.0, step: V.Stride = 0.001, knobView: KnobView, onEditingChanged: @escaping (Bool) -> Void = { _ in }) {
        self.init(value: value, in: bounds, step: step, trackView: Rectangle(), valueView: Rectangle(), knobView: knobView, onEditingChanged: onEditingChanged)
    }
}

extension ValueSlider where TrackView == Rectangle, KnobView == Rectangle {
    public init(value: Binding<V>, in bounds: ClosedRange<V> = 0.0...1.0, step: V.Stride = 0.001, valueView: ValueView, onEditingChanged: @escaping (Bool) -> Void = { _ in }) {
        self.init(value: value, in: bounds, step: step, trackView: Rectangle(), valueView: valueView, knobView: Rectangle(), onEditingChanged: onEditingChanged)
    }
}

extension ValueSlider where TrackView == Rectangle, ValueView == Rectangle, KnobView == Rectangle {
    public init(value: Binding<V>, in bounds: ClosedRange<V> = 0.0...1.0, step: V.Stride = 0.001, onEditingChanged: @escaping (Bool) -> Void = { _ in }) {
        self.init(value: value, in: bounds, step: step, trackView: Rectangle(), valueView: Rectangle(), knobView: Rectangle(), onEditingChanged: onEditingChanged)
    }
}
