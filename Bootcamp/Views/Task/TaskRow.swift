import SwiftUI

struct TaskRow: View {
    let text: String
    let isCompleted: Bool
    let action: () -> Void

    var body: some View {
        HStack {
            Button {
                action()
            } label: {
                Image(systemName: isCompleted ? "checkmark.circle" : "circle" )
                    .font(.headline)
                    .foregroundStyle(isCompleted ? .gray : .primary )
                    .padding(2)
            }

            Text(text)
                .font(.callout)
                .kerning(0.5)
                .foregroundStyle(isCompleted ? .gray : .primary )
            Spacer()
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(.gray.opacity(0.1))
        )
    }
}

#Preview {
    TaskRow(text: "Get this shit done.", isCompleted: true) {}
    TaskRow(text: "Get this shit done.", isCompleted: false) {}
}
