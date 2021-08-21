//
//  CanvasView.swift
//  paintApp
//
//  Created by 41nyaa on 2021/08/20.
//
import Foundation
import SwiftUI

struct CanvasView : View {
    @State var mode = PaintMode.line
    @State var color = Color(.sRGB, red: 0, green: 0, blue: 0)
    @EnvironmentObject var setting: Setting
    @State var points: [CGPoint] = []
    @StateObject var shapes: ShapeParamViewModel = ShapeParamViewModel()
    @State var image: UIImage = UIImage()

    func openImage(imageUrl: URL) {
        do {
            let data = try Data(contentsOf: imageUrl)
            self.image = UIImage(data: data)!
        } catch {
            fatalError("Load Image Error.fa")
        }
    }

    func undo() {
        shapes.undo()
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
        for (index, shape) in self.shapes.params.reversed().enumerated() {
            var found = false
            if shape.points == nil {
                continue
            }
            if (isInShape(selected: self.points[0], top: shape.points!.first!, last: shape.points!.last!)) {
                found = true
            }
            if (found) {
                print("moveShape", index)
                shapes.move(index: self.shapes.params.count - 1 - index, x: moveX, y: moveY)
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
            if (mode == PaintMode.select) {
                print("select")
                moveShape()
            } else {
                self.shapes.add(mode: self.mode, points: self.points, color: self.color, weight: self.setting.data.weight)
            }
            self.points = []
        }
    }

    var body: some View {
        VStack {
            Toolbar(mode: $mode, color: $color, undo: self.undo, openImage: self.openImage)
            ZStack {
                Image(uiImage: self.image)
                    .resizable()
                Rectangle()
                    .fill(Color.clear)
                    .border(Color.black)
                ForEach(self.shapes.params) { shape in
                    if shape.mode == PaintMode.line.rawValue {
                        StrokeShape(param: shape)
                    }
                    else if shape.mode == PaintMode.ellipse.rawValue {
                        EllipseShape(param: shape)
                    }
                    else if shape.mode == PaintMode.rectangle.rawValue {
                        RectangleShape(param: shape)
                    }
                }
            }
            .frame(width: 400, height: 400)
            .gesture(drag)
//            .overlay(
//            )
        }
    }
}

//struct CanvasView_Previews: PreviewProvider {
//    static var previews: some View {
//        CanvasView()
//    }
//}
