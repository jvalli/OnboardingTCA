//
//  AnimatedGradientView.swift
//  OnboardingTCA
//
//  Created by Jerónimo Valli on 5/22/25.
//

import SwiftUI

struct AnimatedGradientView: View {
    @State private var firstAnimation = false
    @State private var secondAnimation = false
    
    var body: some View {
        MeshGradient(
            width: 3,
            height: 3,
            points: [
                [0.0, 0.0], [secondAnimation ? 0.5 : 1.0, 0.0], [1.0, 0.0],
                [0.0, 0.5], firstAnimation ? [0.1, 0.5] : [0.8, 0.2], [1.0, -0.5],
                [0.0, 1.0], [firstAnimation ? 0.1 : 1.0, secondAnimation ? 2.0 : 1.0], [1.0, 1.0]
            ],
            colors: [
                Color.gray.opacity(0.05), Color.gray.opacity(0.4), Color.gray.opacity(0.2),
                Color.gray.opacity(0.2), Color.gray.opacity(0.05), Color.gray.opacity(0.4),
                Color.gray.opacity(0.4), Color.gray.opacity(0.2), Color.gray.opacity(0.05)
            ]
        )
        .onAppear {
            withAnimation(.easeInOut(duration: 2.0).repeatForever(autoreverses: true)) {
                firstAnimation.toggle()
            }
            withAnimation(.easeInOut(duration: 1.2).repeatForever(autoreverses: true)) {
                secondAnimation.toggle()
            }
        }
        .ignoresSafeArea(.all)
    }
}

#Preview {
    AnimatedGradientView()
}
