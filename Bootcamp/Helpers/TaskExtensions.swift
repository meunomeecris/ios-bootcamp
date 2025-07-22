import Foundation

extension TaskStore {
    static var taskPreview: TaskStore {
        let store = TaskStore()
        store.userTasks = [
            TaskTracker(title: "Go shopping", date: Date(), isCompleted: true),
            TaskTracker(title: "Feed the dog", date: Date(), isCompleted: true),
            TaskTracker(title: "Go shopping", date: Date(), isCompleted: false),
            TaskTracker(title: "Feed the dog", date: Date(), isCompleted: true),
            TaskTracker(title: "Go shopping", date: Date(), isCompleted: false),
            TaskTracker(title: "Feed the dog", date: Date(), isCompleted: true)
        ]
        return store
    }
}
