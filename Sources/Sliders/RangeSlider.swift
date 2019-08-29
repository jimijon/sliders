import SwiftUI

public struct RangeSlider<V, TrackView: InsettableShape, ValueView: View, KnobView : InsettableShape>: View where V : BinaryFloatingPoint, V.Stride : BinaryFloatingPoint {
    let range: Binding<ClosedRange<V>>
    let bounds: ClosedRange<V>
    let step: V
    
    let trackView: TrackView
    let valueView: ValueView
    let knobView: KnobView
    
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
                        .frame(width: geometry.size.width, height: self.thickness)
                                    
                    self.valueView
                        .foregroundColor(self.valueColor)
                        .frame(width: geometry.size.width, height: self.thickness)
                        .cornerRadius(self.trackCornerRadius ?? self.thickness / 2)
                        .mask(
                            Rectangle()
                                .frame(
                                    width: self.clippedValue ? (self.valueWidth(overallWidth: geometry.size.width) + self.knobSize.width) : geometry.size.width,
                                    height: self.thickness
                                )
                                .fixedSize()
                                .offset(x: self.clippedValue ? self.maskOffset(overallWidth: geometry.size.width) : 0)
                        )
                }
                .overlay(
                    self.trackView
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
                    .offset(x: self.xForLowerBound(width: geometry.size.width))
                    .gesture(
                        DragGesture()
                            .onChanged { value in
                                if self.dragOffsetX == nil {
                                    self.dragOffsetX = value.startLocation.x - self.xForLowerBound(width: geometry.size.width)
                                }
                                let relativeValue: CGFloat = (value.location.x - (self.dragOffsetX ?? 0)) / (geometry.size.width - self.knobSize.width * 2)
                                let newLowerBound = V(CGFloat(self.bounds.lowerBound) + (relativeValue * CGFloat(self.bounds.upperBound - self.bounds.lowerBound)))
                                let steppedNewLowerBound = round(newLowerBound / self.step) * self.step
                                let validatedLowerBound = max(self.bounds.lowerBound, steppedNewLowerBound)
                                let validatedUpperBound = max(validatedLowerBound, self.range.wrappedValue.upperBound)
                                self.range.wrappedValue = (validatedLowerBound...validatedUpperBound).clamped(to: self.bounds)
                                self.onEditingChanged(true)
                            }
                            .onEnded { _ in
                                self.dragOffsetX = nil
                                self.onEditingChanged(false)
                            }
                    )

                self.knobView
                    .overlay(
                        self.knobView
                            .strokeBorder(self.knobBorderColor, lineWidth: self.knobBorderWidth)
                    )
                    .frame(width: self.knobSize.width, height: self.knobSize.height)
                    .cornerRadius(self.knobCornerRadius)
                    .rotation3DEffect(Angle(degrees: 180), axis: (x: 1, y: 0, z: 0))
                    .rotationEffect(Angle(degrees: 180))
                    .foregroundColor(self.knobColor)
                    .shadow(color: self.knobShadowColor, radius: self.knobShadowRadius, x: self.knobShadowX, y: self.knobShadowY)
                    .offset(x: self.knobSize.width + self.xForUpperBound(width: geometry.size.width))
                    .gesture(
                        DragGesture()
                            .onChanged { value in
                                if self.dragOffsetX == nil {
                                    self.dragOffsetX = self.knobSize.width - (value.startLocation.x - self.xForUpperBound(width: geometry.size.width))
                                }
                                let relativeValue: CGFloat = ((value.location.x - self.knobSize.width) + (self.dragOffsetX ?? 0)) / (geometry.size.width - self.knobSize.width * 2)
                                let newUpperBound = V(CGFloat(self.bounds.lowerBound) + (relativeValue * CGFloat(self.bounds.upperBound - self.bounds.lowerBound)))
                                let steppedNewUpperBound = round(newUpperBound / self.step) * self.step
                                let validatedUpperBound = min(self.bounds.upperBound, steppedNewUpperBound)
                                let validatedLowerBound = min(validatedUpperBound, self.range.wrappedValue.lowerBound)
                                self.range.wrappedValue = (validatedLowerBound...validatedUpperBound).clamped(to: self.bounds)
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
        let halfWidth = ((overallWidth - self.knobSize.width * 2) / 2)
        return (xForLowerBound(width: overallWidth) - halfWidth) + valueWidth(overallWidth: overallWidth) / 2
    }
    
    func valueWidth(overallWidth: CGFloat) -> CGFloat {
        xForUpperBound(width: overallWidth) - xForLowerBound(width: overallWidth)
    }
    
    func xForLowerBound(width: CGFloat) -> CGFloat {
        (width - self.knobSize.width * 2) * (CGFloat(self.range.wrappedValue.lowerBound - bounds.lowerBound) / CGFloat(bounds.upperBound - bounds.lowerBound))
    }
    
    func xForUpperBound(width: CGFloat) -> CGFloat {
        (width - self.knobSize.width * 2) * (CGFloat(self.range.wrappedValue.upperBound - bounds.lowerBound) / CGFloat(bounds.upperBound - bounds.lowerBound))
    }
}

#if DEBUG

struct RangeSlider_Previews: PreviewProvider {
    
    static var previews: some View {
        RangeSlider(range: .constant(0...1))
    }
}
#endif
