import SwiftUI
import Sliders

struct SliderStyleExamplesView: View {
    @State var value1 = 0.5
    @State var value2 = 0.5
    @State var value3 = 0.5
    @State var value4 = 0.5
    @State var value5 = 0.5
    @State var range1 = 0.1...0.9
    @State var range2 = 0.1...0.9
    @State var range3 = 0.1...0.9
    @State var range4 = 0.1...0.9
    @State var range5 = 0.1...0.9
    @State var range6 = 0.1...0.9
    @State var range7 = 0.1...0.9
    @State var range8 = 0.1...0.9
    
    var body: some View {
        ScrollView {
            Group {
                ValueSlider(value: $value1, step: 0.01)
                
                ValueSlider(value: $value2, valueView:
                        LinearGradient(gradient: Gradient(colors: [.red, .orange, .yellow, .green, .blue, .purple, .pink]), startPoint: .leading, endPoint: .trailing)
                    )
                    .clippedValue(false)
                
                ValueSlider(value: $value3)
                    .knobSize(CGSize(width: 16, height: 16))
                    .thickness(6)
                
                ValueSlider(value: $value4, valueView:
                        LinearGradient(gradient: Gradient(colors: [.white, .blue]), startPoint: .leading, endPoint: .trailing)
                    )
                    .knobSize(CGSize(width: 48, height: 16))
                    .thickness(6)
                    .clippedValue(false)
                    .knobBorderColor(.red)
                    .knobBorderWidth(2)
                
                ValueSlider(value: $value5, valueView:
                        LinearGradient(gradient: Gradient(colors: [.black, .blue]), startPoint: .leading, endPoint: .trailing)
                    )
                    .knobSize(CGSize(width: 16, height: 24))
                    .thickness(6)
                    .clippedValue(false)
            }
            
            Group {
                RangeSlider(range: $range1, step: 0.01)
                    .knobBorderWidth(3)
                    .knobBorderColor(.purple)
                    .knobShadowColor(.clear)
                    .clippedValue(false)
                    .valueColor(.purple)
                
                RangeSlider(range: $range2)
                    .knobColor(.blue)
                    .knobShadowColor(.blue)
                    .knobShadowRadius(4)
                    .clippedValue(false)
                
                RangeSlider(range: $range3, valueView:
                        LinearGradient(gradient: Gradient(colors: [.red, .orange, .yellow, .green, .blue, .purple, .pink]), startPoint: .leading, endPoint: .trailing)
                    )
                    .clippedValue(false)

                RangeSlider(
                    range: $range4,
                    valueView: LinearGradient(gradient: Gradient(colors: [.green, .yellow, .red]), startPoint: .leading, endPoint: .trailing),
                    knobView: Capsule()
                )
                .knobSize(CGSize(width: 16, height: 24))
                .thickness(8)
                .knobCornerRadius(8)
                
                
                RangeSlider(range: $range5)
                    .knobCornerRadius(2)
                
                RangeSlider(range: $range6, valueView:
                        LinearGradient(gradient: Gradient(colors: [.red, .orange, .yellow, .green, .blue, .purple, .pink]), startPoint: .leading, endPoint: .trailing)
                    )
                    .knobSize(CGSize(width: 26, height: 26))
                    .thickness(28)
                    .trackBorderColor(Color.gray)
                    .trackBorderWidth(1)
                
                RangeSlider(range: $range7, valueView:
                        LinearGradient(gradient: Gradient(colors: [.blue, .red]), startPoint: .leading, endPoint: .trailing)
                    )
                    .knobSize(CGSize(width: 48, height: 24))
                    .thickness(8)
                    .knobCornerRadius(8)
                    
                
                RangeSlider(
                    range: $range8,
                    valueView: LinearGradient(gradient: Gradient(colors: [.yellow, .orange, .red]), startPoint: .leading, endPoint: .trailing),
                    knobView: CustomKnob()
                )
                .sliderStyle(
                    CustomSliderStyle(
                        height: 72,
                        thickness: 64,
                        knobSize: CGSize(width: 32, height: 64),
                        knobColor: .white,
                        knobCornerRadius: 4,
                        knobBorderColor: .clear,
                        knobBorderWidth: 1,
                        knobShadowColor: .gray,
                        knobShadowRadius: 1,
                        knobShadowX: 0,
                        knobShadowY: 0,
                        trackColor: Color.secondary.opacity(0.25),
                        trackCornerRadius: 4,
                        trackBorderColor: .clear,
                        trackBorderWidth: 0,
                        clippedValue: true
                    )
                )
                .padding(.horizontal, 32)
            }
        }
        .padding()
    }
}


struct SliderStyleExamplesView_Previews: PreviewProvider {
    static var previews: some View {
        SliderStyleExamplesView()
    }
}
