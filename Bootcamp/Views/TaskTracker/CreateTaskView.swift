import SwiftUI

struct CreateTaskView: View {
    @Bindable var store: TaskStore
    @FocusState private var taskFieldIsFocused: Bool
    
    var body: some View {
        VStack {
            Text("Create Task")
                .font(.title2)
                .bold()
                .foregroundStyle(.black)
            
            TextField("Add Task", text: $store.titleTaskInput)
                .focused($taskFieldIsFocused)
                .font(.body)
                .padding(16)
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .fill(.gray.opacity(0.1))
                )
                .onSubmit {
                    store.addTask()
                    store.isCreateTaskActive.toggle()
                }
            TaskButton(icon: "checkmark.circle") {
                store.addTask()
                store.isCreateTaskActive.toggle()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
        }
        .padding(.top, 40)
        .padding(.horizontal, 16)
    }
}


#Preview(body: {
    CreateTaskView(store: TaskStore())
        .padding(16)
})


struct TaskButton: View {
    let icon: String
    let action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            Image(systemName: icon)
                .font(.title)
                .foregroundStyle(.white)
                .padding(12)
        }
        .background(
            Circle()
                .fill(.green)
                .shadow(color: .green, radius: 12, x: 3, y: 3)
        )
    }
}
