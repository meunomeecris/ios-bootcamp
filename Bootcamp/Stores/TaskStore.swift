import Foundation

@Observable
final class TaskStore {
    var userTasks: [TaskTracker] = []
    var titleTaskInput: String = ""
    var isCreateTaskActive: Bool = false
    var isFilterTaskActive: Bool = false
    var showAlertTaskCompleted: Bool = false
    
    var currentFilter: TaskFilter = .all
    
    var filteredTasks: [TaskTracker] {
        switch currentFilter {
        case .all:
            return userTasks
        case .completed:
            return userTasks.filter { $0.isCompleted }
        case .pending:
            return userTasks.filter { !$0.isCompleted }
        case .today:
            return userTasks.filter { Calendar.current.isDateInToday($0.date) }
        }
    }

    private func createTask() -> TaskTracker {
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
                showAlertTaskCompleted = true
            }
        }
    }

    func removeAllTasks() {
        userTasks.removeAll()
    }
}
