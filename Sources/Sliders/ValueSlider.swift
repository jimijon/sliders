import SwiftUI

public struct ValueSlider<V, TrackView: InsettableShape, ValueView: View, KnobView : InsettableShape>: View where V : BinaryFloatingPoint, V.Stride : BinaryFloatingPoint {
    let value: Binding<V>
    let bounds: ClosedRange<V>
    let step: V

    var trackView: TrackView
    var valueView: ValueView
    var knobView: KnobView
    
    let onEditingChanged: (Bool) -> Void
    
    var height: CGFloat = 44
    var thickness: CGFloat = 3
    var knobSize: CGSize = CGSize(width: 27, height: 27)
    var knobColor: Color = .white
    var knobCornerRadius: CGFloat = 13.5
    var knobBorderColor: Color = .clear
    var knobBorderWidth: CGFloat = 0
    var knobShadowColor: Color = Color.black.opacity(0.3)
    var knobShadowRadius: CGFloat = 2
    var knobShadowX: CGFloat = 0
    var knobShadowY: CGFloat = 1.5
    var valueColor: Color = .accentColor
    var trackColor: Color = Color.secondary.opacity(0.25)
    var trackCornerRadius: CGFloat? = nil
    var trackBorderColor: Color = .clear
    var trackBorderWidth: CGFloat = 0
    var clippedValue: Bool = true
    
    @State private var dragOffsetX: CGFloat? = nil
    
    public var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .init(horizontal: .leading, vertical: .center)) {
                Group {
                    self.trackView
                        .foregroundColor(self.trackColor)
                        .frame(height: self.thickness)
                        .cornerRadius(self.trackCornerRadius ?? self.thickness / 2)

                    self.valueView
                        .foregroundColor(self.valueColor)
                        .frame(height: self.thickness)
                        .cornerRadius(self.trackCornerRadius ?? self.thickness / 2)
                        .mask(
                            Rectangle()
                                .frame(
                                    width: self.clippedValue ? (self.xForValue(width: geometry.size.width) + self.knobSize.width) : geometry.size.width,
                                    height: self.thickness
                                )
                                .fixedSize()
                                .offset(x: self.clippedValue ? self.maskOffset(overallWidth: geometry.size.width) : 0)
                        )
                }
                .overlay(
                    RoundedRectangle(cornerRadius: self.trackCornerRadius ?? self.thickness / 2)
                        .strokeBorder(self.trackBorderColor, lineWidth: self.trackBorderWidth)
                )

                self.knobView
                    .overlay(
                        self.knobView
                            .strokeBorder(self.knobBorderColor, lineWidth: self.knobBorderWidth)
                    )
                    .frame(width: self.knobSize.width, height: self.knobSize.height)
                    .cornerRadius(self.knobCornerRadius)
                    .foregroundColor(self.knobColor)
                    
                    .shadow(color: self.knobShadowColor, radius: self.knobShadowRadius, x: self.knobShadowX, y: self.knobShadowY)
                    .offset(x: self.xForValue(width: geometry.size.width))
                    .gesture(
                        DragGesture()
                            .onChanged { value in
                                if self.dragOffsetX == nil {
                                    self.dragOffsetX = value.startLocation.x - self.xForValue(width: geometry.size.width)
                                }
                                let relativeValue: CGFloat = (value.location.x - (self.dragOffsetX ?? 0)) / (geometry.size.width - self.knobSize.width)
                                let newValue = V(CGFloat(self.bounds.lowerBound) + (relativeValue * CGFloat(self.bounds.upperBound - self.bounds.lowerBound)))
                                let steppedNewValue = round(newValue / self.step) * self.step
                                let validatedValue = min(self.bounds.upperBound, max(self.bounds.lowerBound, steppedNewValue))
                                self.value.wrappedValue = validatedValue
                                self.onEditingChanged(true)
                            }
                            .onEnded { _ in
                                self.dragOffsetX = nil
                                self.onEditingChanged(false)
                            }
                    )
            }
            .frame(height: self.height)
        }
        .frame(height: self.height)
    }
    
    func maskOffset(overallWidth: CGFloat) -> CGFloat {
        return (xForValue(width: overallWidth) - overallWidth) / 2
    }
    
    func xForValue(width: CGFloat) -> CGFloat {
        (width - self.knobSize.width) * (CGFloat(self.value.wrappedValue - bounds.lowerBound) / CGFloat(bounds.upperBound - bounds.lowerBound))
    }
}

#if DEBUG

struct ValueSlider_Previews: PreviewProvider {
    
    static var previews: some View {
        ValueSlider(value: .constant(0.5), knobView: CustomKnob())
            .height(100)
            .knobColor(.blue)
            .knobBorderWidth(4)
            .knobCornerRadius(0)
            .knobBorderColor(.red)
            .previewLayout(.fixed(width: 300, height: 100))
    }
}
#endif
