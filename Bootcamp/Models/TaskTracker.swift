import Foundation

struct TaskTracker: Identifiable, Equatable {
    var id = UUID()
    var title: String
    var date: Date
    var isCompleted: Bool
}


enum TaskFilter: String, CaseIterable {
    case all = "All"
    case completed = "Completed"
    case pending = "Pending"
    case today = "Today"
}
