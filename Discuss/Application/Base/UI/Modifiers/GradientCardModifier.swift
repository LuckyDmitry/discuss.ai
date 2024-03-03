import SwiftUI

extension RoundedRectangle {
    func cardGradient(color: Color) -> some View {
        self
            .fill(LinearGradient(colors: [color.opacity(0.3), color], startPoint: .topTrailing, endPoint: .bottomLeading))
    }
}
