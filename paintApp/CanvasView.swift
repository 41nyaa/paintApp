//
//  Canvas.swift
//  paintApp
//
//  Created by 41nyaa on 2021/07/26.
//

import Foundation
import SwiftUI

struct CanvasView : View {
    @State var mode = PaintMode.line
    @State var color = Color(.sRGB, red: 0, green: 0, blue: 0)
    @State var weight: Int = 6
    @State var points: [CGPoint] = []
    @State var shapes: [ShapeParam] = []

    func undo() {
        if (shapes.count > 0) {
            shapes.removeLast()
        }
    }
    
    func isInShape(selected: CGPoint, top: CGPoint, last: CGPoint) -> Bool {
        let minX = (top.x < last.x) ? top.x : last.x
        let maxX = (top.x < last.x) ? last.x : top.x
        let minY = (top.y < last.y) ? top.y : last.y
        let maxY = (top.y < last.y) ? last.y : top.y
        if (minX <= selected.x) &&
            (selected.x <= maxX) &&
            (minY <= selected.y) &&
            (selected.y <= maxY) {
            return true
        }
        return false
    }
    
    func moveShape() {
        let moveX = points.last!.x - points[0].x
        let moveY = points.last!.y - points[0].y
        for (sindex, shape) in self.shapes.reversed().enumerated() {
            var found = false
            if (isInShape(selected: self.points[0], top: shape.points[0], last: shape.points.last!)) {
                found = true
            }
            if (found) {
                for (pindex, point) in shape.points.enumerated() {
                    shapes[self.shapes.count - 1 - sindex].points[pindex] = CGPoint(x: point.x + moveX, y: point.y + moveY)
                }
                break
            }
        }

    }
    
    var drag: some Gesture{
        DragGesture()
        .onChanged{ value in
            self.points.append(value.location)
        }
        .onEnded{ value in
            if (mode != PaintMode.select) {
                self.shapes.append(ShapeParam(mode: self.mode, points: self.points, color: self.color, weight: CGFloat(self.weight)))
            } else {
                moveShape()
            }
            self.points = []
        }
    }

    var body: some View {
        VStack {
            Toolbar(mode: $mode, color: $color, weight: $weight, undo: self.undo)
            Rectangle()
                .fill(Color.white)
                .border(Color.black)
                .frame(width: 400, height: 400)
                .gesture(drag)
                .overlay(
                    ZStack {
                        ForEach(0..<shapes.count, id:\.self) { index in
                            if self.shapes[index].mode == PaintMode.line {
                                StrokeShape(param: self.shapes[index])
                            }
                            else if self.shapes[index].mode == PaintMode.ellipse {
                                EllipseShape(param: self.shapes[index])
                            }
                       }
                    }
                )
        }
    }
}
