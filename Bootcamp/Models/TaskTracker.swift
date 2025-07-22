import Foundation

struct TaskTracker: Identifiable, Equatable {
    var id = UUID()
    var title: String
    var date: Date
    var isCompleted: Bool
}
