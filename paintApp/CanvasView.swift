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

    var drag: some Gesture{
        DragGesture()
        .onChanged{ value in
            self.points.append(value.location)
        }
        .onEnded{ value in
            self.shapes.append(ShapeParam(mode: self.mode, points: self.points, color: self.color, weight: CGFloat(self.weight)))
            self.points = []
        }
    }

    var body: some View {
        VStack {
            Toolbar(mode: $mode, color: $color, weight: $weight)
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
                       }
                    }
                )
        }
    }
}
