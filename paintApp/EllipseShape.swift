//
//  EllipseShape.swift
//  paintApp
//
//  Created by 41nyaa on 2021/08/03.
//

import Foundation
import SwiftUI

struct EllipseShape: View {
    var color: Color
    var points: [CGPoint]
    var weight: Int16
    
    init(color: Color, points: [CGPoint], weight: Int16) {
        self.color = color
        self.points = points
        self.weight = weight
    }

    func calcPosition(p1: CGPoint, p2: CGPoint) -> CGPoint {
        var x: CGFloat = 0.0
        if ( p1.x < p2.x) {
            x = (p2.x - p1.x) / 2.0 + p1.x
        } else {
            x = (p1.x - p2.x) / 2.0 + p2.x
        }
        var y: CGFloat = 0.0
        if ( p1.y < p2.y) {
            y = (p2.y - p1.y) / 2.0 + p1.y
        } else {
            y = (p1.y - p2.y) / 2.0 + p2.y
        }
        return CGPoint(x: x, y: y)
    }
    
    var body: some View {
        Ellipse()
            .stroke(style: .init(lineWidth: CGFloat(self.weight)))
            .fill(self.color)
            .frame(width: abs(self.points.first!.x - self.points.last!.x),
                   height: abs(self.points.first!.y - self.points.last!.y))
            .position(calcPosition(p1: self.points.first!, p2: self.points.last!))
    }
}
