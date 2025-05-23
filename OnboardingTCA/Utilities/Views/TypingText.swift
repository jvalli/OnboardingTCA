//
//  TypingText.swift
//  OnboardingTCA
//
//  Created by Jerónimo Valli on 5/23/25.
//

import SwiftUI

struct TypingText: View {
    let text: String
    var speed = Constants.typingTextAnimationSpeed
    var onFinished: (() -> Void)? = nil
    
    @State private var displayedText: String = .empty
    @State private var currentIndex = 0
    @State private var timer: Timer?
    
    struct Constants {
        static let messageTextColorOpacity = 0.8
        static let typingTextAnimationSpeed = 0.1
    }
    
    var body: some View {
        Text(displayedText)
            .font(.helveticaNeue(size: .messageSize))
            .multilineTextAlignment(.center)
            .foregroundStyle(Color.indigoBlue.opacity(Constants.messageTextColorOpacity))
            .onAppear {
                startTyping()
            }
            .onDisappear {
                stopTyping()
            }
    }
    
    private func startTyping() {
        displayedText = .empty
        currentIndex = 0
        timer = Timer.scheduledTimer(withTimeInterval: speed, repeats: true) { _ in
            if currentIndex < text.count {
                let index = text.index(text.startIndex, offsetBy: currentIndex)
                displayedText.append(text[index])
                currentIndex += 1
            } else {
                stopTyping()
                onFinished?()
            }
        }
    }
    
    private func stopTyping() {
        timer?.invalidate()
        timer = nil
    }
}
