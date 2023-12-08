//
//  TaskModel.swift
//  Assignment26-swift-UI
//
//  Created by Luka Gazdeliani on 08.12.23.
//

import Foundation

struct Task: Identifiable {
    var id = UUID()
    let name: String
    let time: String
    var isCompleted: Bool
    var taskState: TaskState
}
