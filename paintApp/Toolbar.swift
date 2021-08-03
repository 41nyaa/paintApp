//
//  Toolbar.swift
//  paintApp
//
//  Created by 41nyaa on 2021/07/26.
//

import Foundation
import SwiftUI

public enum PaintMode {
    case select
    case ellipse
    case rectangle
    case line
}

struct Toolbar : View {
    @Binding var mode: PaintMode
    @Binding var color: Color
    @Binding var weight: Int
    var undo: () -> Void

    var body: some View
    {
        VStack {
            HStack {
                Spacer()
                Picker("\(weight)", selection: $weight) {
                    Text("1").tag(1)
                    Text("2").tag(2)
                    Text("3").tag(3)
                    Text("4").tag(4)
                    Text("5").tag(5)
                    Text("6").tag(6)
                    Text("7").tag(7)
                    Text("8").tag(8)
                    Text("9").tag(9)
                    Text("10").tag(10)
                }
                .pickerStyle(MenuPickerStyle())
                Button(action: undo) {
                    Image(systemName: "arrow.uturn.backward")
                }
                ColorPicker("", selection: $color)
            }
            Picker("Paint Mode", selection: $mode) {
                Image(systemName: "pencil.slash")
                    .tag(PaintMode.select)
                Image(systemName: "pencil")
                    .tag(PaintMode.line)
                Image(systemName: "pencil.circle")
                    .tag(PaintMode.ellipse)
                Image(systemName: "square.and.pencil")
                    .tag(PaintMode.rectangle)
            }
            .pickerStyle(SegmentedPickerStyle())
        }
    }
}
