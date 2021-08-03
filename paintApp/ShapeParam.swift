//
//  ShapeParameter.swift
//  paintApp
//
//  Created by 41nyaa on 2021/08/02.
//

import Foundation
import SwiftUI

struct ShapeParam: Identifiable {
    var mode: PaintMode
    var points: [CGPoint]
    var color: Color
    var weight: CGFloat
    var id = UUID()
    
    init(mode: PaintMode, points: [CGPoint], color: Color, weight: CGFloat) {
        self.mode = mode
        self.points = points
        self.color = color
        self.weight = weight
    }
}
