//
//  AnimatedButton.swift
//  tracker_geo
//
//  Created by Guvanch Amanov on 23.08.23.
//

import SwiftUI

@available(iOS 17.0, *)
struct AnimatedButton<ButtonContent: View>: View {
    var content: ()-> ButtonContent
    var action: ()async -> TaskStatus
    var buttonTint: Color = Color(hex: 0xFFFFA45B)
    
    @State private var isLoading :Bool = false
    @State private var taskStatus: TaskStatus = .idle
    @State private var isFailed: Bool = false
    @State private var wiggle: Bool = false
    
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
                    wiggle.toggle()
                    isFailed = true
                    popUpMessage = string
                case .success:
                    isFailed = false
                }
                self.taskStatus = taskStatus
                if isFailed{
                    try? await Task.sleep(for: .seconds(0))
                    wiggle.toggle()
                }
                try? await Task.sleep(for: .seconds(0.8))
                if isFailed{
                    showPopup = true
                }
                self.taskStatus = .idle
                isLoading = false
            }
        },label: {
            content()
                .padding(.vertical,10)
                .padding(.horizontal,30)
                .opacity(isLoading ? 0 : 1)
                .lineLimit(1)
                .frame (width: isLoading ? 50 : nil, height: isLoading ? 50 : nil)
                .background(Color (taskStatus == .idle ?
                                   buttonTint :
                                    taskStatus == .success ?
                    .green :.red).shadow(.drop(color: .black.opacity(0.15), radius:60)),in: .capsule)
                .overlay {
                    if isLoading && taskStatus == .idle {
                        ProgressView()
                    }
                }
                .overlay {
                    if taskStatus != .idle {
                        Image(systemName: isFailed ? "exclamationmark" : "checkmark")
                            .font(.title2.bold())
                            .foregroundColor(.white)
                    }
                }
                .wiggle(wiggle)
        }
        ).disabled(isLoading)
            .popover(isPresented: $showPopup, content: {
                Text(popUpMessage)
                    .font(.caption)
                    .foregroundStyle(.gray)
                    .padding(.horizontal,10)
                    .presentationCompactAdaptation(.popover)
            })
            .animation(.snappy, value: isLoading)
            .animation(.snappy, value: taskStatus)
    }
}

enum TaskStatus: Equatable{
    case idle
    case faild(String)
    case success
}

@available(iOS 17.0, *)
extension View{
    @ViewBuilder
    func wiggle(_ animate:Bool) -> some View {
        self.keyframeAnimator(initialValue: CGFloat.zero, trigger: animate) { view, value in
            view.offset(x: value)
        } keyframes: { _ in
            KeyframeTrack{
                CubicKeyframe(0,duration: 0.1)
                CubicKeyframe(-5,duration: 0.1)
                CubicKeyframe(5,duration: 0.1)
                CubicKeyframe(-5,duration: 0.1)
                CubicKeyframe(5,duration: 0.1)
                CubicKeyframe(-5,duration: 0.1)
                CubicKeyframe(5,duration: 0.1)
                CubicKeyframe(0,duration: 0.1)
            }
        }

    }
}
