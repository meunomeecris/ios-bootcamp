import Foundation

@Observable
final class TaskStore {
    var userTasks: [TaskTracker] = []
    var filteredTask: [TaskTracker] = []
    var titleTaskInput: String = ""
    var isCreateTaskActive: Bool = false
    var isFilterTaskActive: Bool = false
    var isTaskCompleted: Bool = false

    func createTask() -> TaskTracker {
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())
        return TaskTracker(title: titleTaskInput, date: today, isCompleted: false)
    }

    func addTask() {
        userTasks.append(createTask())
        titleTaskInput = ""
    }

    func completeTask(_ task: TaskTracker) {
        if let index = userTasks.firstIndex(where: { $0.id == task.id }) {
            userTasks[index].isCompleted.toggle()
            if userTasks[index].isCompleted == true {
                isTaskCompleted = true
            }
        }
    }

    func filterTasksBy() -> [TaskTracker] {
        filteredTask = userTasks.filter { $0.isCompleted == true }
        return filteredTask
    }

    func filterTaskByDate() -> [TaskTracker] {
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())

        return userTasks.filter { $0.date < today }
    }

    func removeAllTasks() {
        userTasks.removeAll()
    }
}
