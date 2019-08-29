import Foundation
import SwiftUI

public struct CustomKnob: View, InsettableShape {
    private let inset: CGFloat

    public func inset(by amount: CGFloat) -> CustomKnob {
        CustomKnob(inset: self.inset + amount)
    }
    
    public func path(in rect: CGRect) -> Path {
        let width = rect.size.width - inset * 2
        let height = rect.size.height - inset * 2
        return Path { path in
            path.move(to: CGPoint(x: width, y: 0))
            path.addLine(to: CGPoint(x: width, y: height))
            path.addLine(to: CGPoint(x: width / 2, y: height))
            path.addQuadCurve(to: CGPoint(x: width / 2, y: 0), control: CGPoint(x: -(width / 2), y: height / 2))
            path.addLine(to: CGPoint(x: width, y: 0))
            path.closeSubpath()
        }.offsetBy(dx: inset, dy: inset)
    }
    
    public var body: some View {
        GeometryReader { geometry in
            self.path(in: CGRect(x: 0, y: 0, width: geometry.size.width, height: geometry.size.height))
        }
    }
    
    public init(inset: CGFloat = 0) {
        self.inset = inset
    }

}
