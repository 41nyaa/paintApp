//
//  StrokeShape.swift
//  paintApp
//
//  Created by 41nyaa on 2021/07/30.
//

import Foundation
import SwiftUI

struct StrokeShape: View {
    var param: ShapeParam
    
    var body: some View {
        Path { path in
            for (index, point) in self.param.points!.enumerated() {
                if (index == 0) {
                    path.move(to: point)
                } else {
                    path.addLine(
                        to: point
                    )
                }
            }
        }
        .stroke(style: .init(lineWidth: CGFloat(param.weight)))
        .fill(param.getColor()!)
    }
}
