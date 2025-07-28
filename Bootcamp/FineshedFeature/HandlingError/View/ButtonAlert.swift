import SwiftUI

public struct ButtonAlert: View {
    let name: String
    let color: Color
    let bgColor: Color
    let action: ()->Void
    
    public init(name: String, color: Color, bgColor: Color, action: @escaping () -> Void) {
        self.name = name
        self.color = color
        self.bgColor = bgColor
        self.action = action
    }
    
    public var body: some View {
        Button(name, systemImage: "bell.fill") {
            action()
        }
        .font(.body)
        .textCase(.uppercase)
        .bold()
        .foregroundStyle(color)
        .padding(16)
        .frame(width: 200)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(bgColor)
                .shadow(color: bgColor.opacity(0.3), radius:1, x:10, y:10)
        )
    }
}
