//
//  StrokeShape.swift
//  paintApp
//
//  Created by 41nyaa on 2021/07/30.
//

import Foundation
import SwiftUI

struct StrokeShape: View {
    var color: Color
    var points: [CGPoint]
    var weight: Int16
    
    init(color: Color, points: [CGPoint], weight: Int16) {
        self.color = color
        self.points = points
        self.weight = weight
    }

    var body: some View {
        Path { path in
            for (index, point) in self.self.points.enumerated() {
                if (index == 0) {
                    path.move(to: point)
                } else {
                    path.addLine(
                        to: point
                    )
                }
            }
        }
        .stroke(style: .init(lineWidth: CGFloat(self.weight)))
        .fill(self.color)
    }
}
