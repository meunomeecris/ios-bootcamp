import SwiftUI

struct TaskFilterView: View {
    @Bindable var store: TaskStore
    
    var body: some View {
        List {
            Picker(selection: $store.currentFilter) {
                Text("All Tasks").tag(TaskFilter.all)
                Text("Completed").tag(TaskFilter.completed)
                Text("Pendind").tag(TaskFilter.pending)
                Text("Created Today").tag(TaskFilter.today)
            } label: {
                Text("Filter tasks by")
            }
        }
    }
}

#Preview {
    TaskFilterView(store: TaskStore())
}
