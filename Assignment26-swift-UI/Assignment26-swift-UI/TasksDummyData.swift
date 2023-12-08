//
//  TasksDummyData.swift
//  Assignment26-swift-UI
//
//  Created by Luka Gazdeliani on 08.12.23.
//

import Foundation

final class TasksDummyData: ObservableObject {
    
    @Published var completedTasks = [
        Task(name: "Mobile App Research", time: "4 Oct", isCompleted: true, taskState: .finished()),
        Task(name: "Prepare Wireframe for Main Flow", time: "4 Oct", isCompleted: true, taskState: .finished()),
        Task(name: "Prepare Screens", time: "4 Oct", isCompleted: true, taskState: .finished()),
    ]
    
    @Published var incompleteTasks = [
        Task(name: "Website Research", time: "5 Oct", isCompleted: false, taskState: .asap()),
        Task(name: "Prepare Wireframe for Main Flow", time: "5 Oct", isCompleted: false, taskState: .important()),
        Task(name: "Prepare Screens", time: "5 Oct", isCompleted: false, taskState: .unimportant()),
    ]
}
