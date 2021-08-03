//
//  EllipseShape.swift
//  paintApp
//
//  Created by 41nyaa on 2021/08/03.
//

import Foundation
import SwiftUI

struct EllipseShape: View {
    var param: ShapeParam
    
    init(param: ShapeParam) {
        self.param = param
        print(param.points[0].x,  param.points[param.points.count-1].x)
        print(param.points[0].y,  param.points[param.points.count-1].y)
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
            .stroke(style: .init(lineWidth: param.weight))
            .fill(param.color)
            .frame(width: abs(param.points[0].x - param.points[param.points.count-1].x),
                   height: abs(param.points[0].y - param.points[param.points.count-1].y))
            .position(calcPosition(p1: param.points[0], p2: param.points[param.points.count-1]))
    }
}
