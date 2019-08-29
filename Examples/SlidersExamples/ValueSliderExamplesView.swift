import SwiftUI
import Sliders

struct ValueSliderExamplesView: View {
    @State var nativeValue = 1500.0
    @State var value1 = 0.5
    @State var value2 = 75.0
    @State var value3 = 0.5
    @State var value4 = 0.5
    
    var body: some View {
        ScrollView {
            Slider(value: $nativeValue, in: 1000...2000)
            HStack {
                Text("Value")
                Spacer()
                Text("\(value1)")
                    .foregroundColor(.secondary)
            }
            ValueSlider(value: $value1, step: 0.01)

            ValueSlider(value: $value2, in: 25...125)
                .clippedValue(false)
            ValueSlider(value: $value3, valueView:
                LinearGradient(gradient: Gradient(colors: [.green, .yellow, .red]), startPoint: .leading, endPoint: .trailing)
            )
            ValueSlider(value: $value4, valueView:
                LinearGradient(gradient: Gradient(colors: [.red, .orange, .yellow, .green, .blue, .purple, .pink]), startPoint: .leading, endPoint: .trailing)
            )
            .clippedValue(false)
        }
        .padding()
    }
}

struct ValueSliderExamplesView_Previews: PreviewProvider {
    static var previews: some View {
        ValueSliderExamplesView()
    }
}
