//
//  AnimatedGradientView.swift
//  OnboardingTCA
//
//  Created by Jerónimo Valli on 5/22/25.
//

import SwiftUI

struct AnimatedGradientView: View {
    
    @State private var gradientStart: UnitPoint = UnitPoint(x: 0, y: 0)
    @State private var gradientEnd: UnitPoint = UnitPoint(x: 0, y: 2)
    
    var body: some View {
        Rectangle()
            .fill(
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color.gray.opacity(0.1),
                        Color.gray.opacity(0.3)
                    ]),
                    startPoint: gradientStart,
                    endPoint: gradientEnd
                )
            )
            .onAppear {
                withAnimation(.easeInOut(duration: 3.0).repeatForever(autoreverses: true)) {
                    gradientStart = UnitPoint(x: 1, y: -1)
                    gradientEnd = UnitPoint(x: 0, y: 1)
                }
            }
    }
}
