//
//  TaskState.swift
//  Assignment26-swift-UI
//
//  Created by Luka Gazdeliani on 08.12.23.
//

import Foundation
import SwiftUI

enum TaskState {
    case finished(color: Color = Color(UIColor(red: 159/255, green: 226/255, blue: 191/255, alpha: 1)))
    case asap(color: Color = Color(UIColor(red: 250/255, green: 203/255, blue: 186/255, alpha: 1)))
    case important(color: Color = Color(UIColor(red: 250/255, green: 217/255, blue: 255/255, alpha: 1)))
    case unimportant(color: Color = Color(UIColor(red: 215/255, green: 240/255, blue: 255/255, alpha: 1)))
    
    var color: Color {
        switch self {
        case .finished(let color):
            return color
        case .asap(let color):
            return color
        case .important(let color):
            return color
        case .unimportant(let color):
            return color
        }
    }

}
