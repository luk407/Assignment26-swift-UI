//
//  ContentView.swift
//  Assignment26-swift-UI
//
//  Created by Luka Gazdeliani on 08.12.23.
//

import SwiftUI

struct TasksView: View {
    
    //MARK: --- Properties
    @StateObject private var dummyData = TasksDummyData()
    
    //MARK: --- Views
    
    private var profilePicView: some View {
        
        ZStack {
            
            Image(.profilePic)
                .resizable()
                .scaledToFill()
                .background(
                    LinearGradient(
                        gradient: Gradient(
                            colors: [Color(UIColor(red: 186/255, green: 131/255, blue: 222/255, alpha: 1)),
                                     Color(UIColor(red: 217/255, green: 217/255, blue: 217/255, alpha: 0))]),
                        startPoint: .top,
                        endPoint: .bottom))
                .frame(width: 45, height: 45)
                .clipShape(Circle())
            
            ZStack {
                
                Circle()
                    .frame(width: 15, height: 15)
                    .foregroundStyle(
                        Color(
                            UIColor(red: 255/255, green: 118/255, blue: 59/255, alpha: 1)))
                
                Text("\(dummyData.incompleteTasks.count)")
                    .font(.system(size: 9))
            }
            .offset(x: 10, y: 20)
        }
    }
    
    private var completeAllButton: some View {
        
        ZStack {
            
            RoundedRectangle(cornerRadius: 8)
                .frame(height: 50)
                .foregroundStyle(
                    LinearGradient(
                        gradient: Gradient(
                            colors: [Color(UIColor(red: 186/255, green: 131/255, blue: 222/255, alpha: 1)),
                                     Color(UIColor(red: 222/255, green: 131/255, blue: 176/255, alpha: 1))]),
                        startPoint: .leading,
                        endPoint: .trailing))
            
            Button("Complete All") {
                dummyData.completedTasks.append(contentsOf: dummyData.incompleteTasks)
                dummyData.incompleteTasks.removeAll()
                dummyData.completedTasks.indices.forEach {
                    dummyData.completedTasks[$0].taskState = .finished()
                }
            }
                .bold()
                .foregroundStyle(.white)
                .font(.system(size: 16))
        }
    }
    
    private var percentageView: some View {
        
        HStack {
            
            Text("Keep working")
                .font(.system(size: 14))
                .foregroundStyle(.white.opacity(0.8))
            
            Spacer()
            
            Text("\(NumberFormatter().string(from: Double(dummyData.completedTasks.count) / Double(dummyData.incompleteTasks.count + dummyData.completedTasks.count) * 100 as NSNumber) ?? "")%")
                .bold()
                .font(.system(size: 18))
        }
    }
    
    private var progressView: some View {
        
        ProgressView(value:
                        Double(dummyData.completedTasks.count) / Double(dummyData.incompleteTasks.count + dummyData.completedTasks.count))
            .tint(Color(UIColor(red: 186/255, green: 131/255, blue: 222/255, alpha: 1)))
            .background(Color(UIColor(red: 186/255, green: 131/255, blue: 222/255, alpha: 0.41)))
            .frame(height: 18)
            .scaleEffect(x: 1, y: 5)
            .clipShape(RoundedRectangle(cornerRadius: 9))
    }
    
    var body: some View {
        VStack(spacing: 20, content: {
            
            HStack {
                
                Text("You have \(dummyData.incompleteTasks.count) tasks to complete")
                    .bold()
                    .font(.system(size: 25))
                
                Spacer()
                
                profilePicView
            }
            
            completeAllButton
            
            HStack {
                Text("Progress")
                    .bold()
                    .font(.system(size: 22))
                Spacer()
            }
            
            ZStack {
                
                RoundedRectangle(cornerRadius: 8)
                    .frame(height: 139)
                    .foregroundStyle(Color(UIColor(red: 24/255, green: 24/255, blue: 24/255, alpha: 1)))
                
                VStack(spacing: 10, content: {
                    
                    HStack {
                        Text("Daily Task")
                            .bold()
                            .font(.system(size: 18))
                        Spacer()
                    }
                    
                    HStack {
                        Text("\(dummyData.completedTasks.count)/\(dummyData.incompleteTasks.count + dummyData.completedTasks.count) Task Completed")
                            .font(.system(size: 16))
                            .foregroundStyle(.white.opacity(0.8))
                        Spacer()
                    }
                    
                    percentageView
                    
                    progressView
                    
                })
                .padding()
                
            }
            
            HStack {
                Text("Completed Tasks")
                    .bold()
                    .font(.system(size: 22))
                Spacer()
            }
            
            List {
                
                Section {
                    
                    ForEach(dummyData.completedTasks) { task in
                        
                        HStack {
                            
                            UnevenRoundedRectangle(cornerRadii: .init(topLeading: 7.5, bottomLeading: 7.5))
                                .frame(width: 15, height: 80)
                                .padding(.leading, -20)
                                .foregroundStyle(task.taskState.color)
                            
                            VStack {
                                
                                HStack {
                                    Text("\(task.name)")
                                        .font(.system(size: 16))
                                    Spacer()
                                }
                                
                                HStack {
                                    Image(.icon)
                                    Text("\(task.time)")
                                        .font(.system(size: 14))
                                        .foregroundStyle(.white.opacity(0.8))
                                    Spacer()
                                }
                            }
                            
                            Button {
                                var switchedTask = task
                                switchedTask.isCompleted = false
                                switchedTask.taskState = .important() // ჩავთვალოთ რო ყველა თასქი by default უბრუნდება important სთეითს თუ გაინიშნება :)
                                dummyData.incompleteTasks.append(switchedTask)
                                if let index = dummyData.completedTasks.firstIndex(where: {$0.id == task.id}) {
                                    dummyData.completedTasks.remove(at: index)
                                }
                            } label: {
                                Image(systemName: "checkmark.circle.fill")
                                    .resizable()
                                    .frame(width: 26,height: 26)
                                    .foregroundStyle(Color(UIColor(red: 186/255, green: 131/255, blue: 222/255, alpha: 1)))
                            }
                        }
                        .frame(height: 80)
                    }
                }
                .listRowBackground(
                    RoundedRectangle(cornerRadius: 8)
                        .fill(.white.opacity(0.1))
                        .padding(.vertical, 10))
                
                Section {
                    
                    ForEach(dummyData.incompleteTasks) { task in
                        
                        HStack {
                            
                            UnevenRoundedRectangle(cornerRadii: .init(topLeading: 7.5, bottomLeading: 7.5))
                                .frame(width: 15, height: 80)
                                .padding(.leading, -20)
                                .foregroundStyle(task.taskState.color)
                            
                            VStack {
                                
                                HStack {
                                    Text(task.name)
                                        .font(.system(size: 16))
                                    Spacer()
                                }
                                
                                HStack {
                                    Image(.icon)
                                    Text(task.time)
                                        .font(.system(size: 14))
                                        .foregroundStyle(.white.opacity(0.8))
                                    Spacer()
                                }
                            }
                            
                            Button {
                                var switchedTask = task
                                switchedTask.isCompleted = true
                                switchedTask.taskState = .finished()
                                dummyData.completedTasks.append(switchedTask)
                                if let index = dummyData.incompleteTasks.firstIndex(where: {$0.id == task.id}) {
                                    dummyData.incompleteTasks.remove(at: index)
                                }
                            } label: {
                                Image(systemName: "circle")
                                    .resizable()
                                    .frame(width: 26,height: 26)
                                    .foregroundStyle(Color(UIColor(red: 186/255, green: 131/255, blue: 222/255, alpha: 1)))
                            }
                        }
                        .frame(height: 80)
                    }
                }
                .listRowBackground(
                    RoundedRectangle(cornerRadius: 8)
                        .fill(.white.opacity(0.1))
                        .padding(.vertical, 10))
            }
            .listStyle(.plain)
            
        })
        .padding()
        .preferredColorScheme(.dark)
    }
}

#Preview {
    TasksView()
}
