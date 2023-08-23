//
//  AnimatedButton.swift
//  tracker_geo
//
//  Created by Guvanch Amanov on 23.08.23.
//

import SwiftUI

struct AnimatedButton<ButtonContent: View>: View {
    var content: ()-> ButtonContent
    var action: ()async -> TaskStatus
    var buttonTint: Color = .white
    
    @State private var isLoading :Bool = false
    @State private var taskStatus: TaskStatus = .idle
    @State private var isFailed: Bool = false
    
    @State private var showPopup: Bool = false
    @State private var popUpMessage: String = ""
    
    var body: some View {
        Button(action:  {
            Task{
                isLoading = true
                let taskStatus = await action()
                switch taskStatus{
                case .idle:
                    isFailed = false
                case .faild(let string):
                    isFailed = true
                    popUpMessage = string
                case .success:
                    isFailed = false
                }
                self.taskStatus = taskStatus
                try? await Task.sleep(for: .seconds(1))
                self.taskStatus = .idle
                isLoading = false
            }
        },label: {
            content()
                .padding(.vertical,10)
                .padding(.horizontal,20)
                .lineLimit(1)
                .frame(width: isLoading ? 50 : nil,height: isLoading ? 50 : nil)
                .background(Color(taskStatus == .idle ? .blue : taskStatus == .success ? .green : .red))
                //.opacity(isLoading ? 0 : 1)
                
            
                .overlay {
                    if isLoading && taskStatus == .idle {
                        ProgressView()
                    }
                }
                .overlay {
                    if taskStatus != .idle {
                        Image(systemName: isFailed ? "exclaminationmark" : "checkmark")
                            .font(.title2.bold())
                            .foregroundColor(.white)
                    }
                }
            
        }
        ).disabled(isLoading)
            .cornerRadius(6)
        .animation(.easeOut, value: isLoading)
        .animation(.easeOut, value: taskStatus)
    }
}

enum TaskStatus: Equatable{
    case idle
    case faild(String)
    case success
}


