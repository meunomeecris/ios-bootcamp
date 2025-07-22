import SwiftUI
import UIComponents

struct TaskView: View {
    @Bindable  var store: TaskStore

    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    ListTaskView(store: store)
                }
                .padding(16)
                .navigationTitle("Task Tracker")
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Button("Delete Tasks") {
                            store.removeAllTasks()
                        }
                    }
                    ToolbarItem(placement: .topBarTrailing) {
                        if store.isFilterTaskActive {
                            Button("Close") {
                                store.isFilterTaskActive = false
                            }
                        } else {
                            Button("Filter") {
                                store.isFilterTaskActive = true
                                store.filterTasksBy()
                            }
                        }
                    }
                }
                .foregroundStyle(.green)
                .bold()

                ButtonView(store: store)
                    .padding()
            }
        }
    }
}

#Preview {
    TaskView(store: .taskPreview)
//    TaskView(store: TaskStore())
}


private struct ButtonView: View {
    @Bindable var store: TaskStore

    var body: some View {
        VStack {
            TaskButton(icon: "plus.circle") {
                store.isCreateTaskActive.toggle()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
            .sheet(isPresented: $store.isCreateTaskActive) {
                CreateTaskView(store: store)
                    .presentationDetents([.fraction(0.3)])
                    .presentationDragIndicator(.visible)
            }
        }
    }
}


private struct ListTaskView: View {
    @Bindable var store: TaskStore

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack {
                if store.userTasks.isEmpty {
                    Text("No tasks yet!")
                        .font(.title2)
                        .foregroundStyle(.black)
                        .opacity(0.6)
                } else {
                    ForEach(store.isFilterTaskActive ? store.filteredTask : store.userTasks) { task in
                        VStack {
                            TaskRow(text: task.title, isCompleted: task.isCompleted) {
                                store.completeTask(task)
                            }
                        }
                        .alert("Congrats!", isPresented: $store.isTaskCompleted) {
                            Button("Thanks") {
                                store.isTaskCompleted = false
                            }
                        } message: {
                            Text("You completed a task! Let's celebrate!")
                        }
                    }
                }
            }
        }
    }
}
