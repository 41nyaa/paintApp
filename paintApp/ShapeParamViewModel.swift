//
//  ShapeParameter.swift
//  paintApp
//
//  Created by 41nyaa on 2021/08/02.
//

import CoreData
import SwiftUI

public class ShapeParamViewModel: ObservableObject {
    private var container: NSPersistentContainer!
    @Published var params : [ShapeParam] = []
    
    init() {
        self.container = NSPersistentContainer(name: "ShapeParamModel")
        self.container.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Failed to load CoreData stack: \(error)")
            }
            do {
                guard let fetchParams = try self.container.viewContext.fetch(ShapeParam.fetchRequest()) as? [ShapeParam] else {
                    fatalError("Fetch CoreData Error.")
                }
                self.params = fetchParams
            } catch {
                fatalError("Fetch CoreData Exception. \(error)")
            }
        }
    }

    func add(mode: PaintMode, points: [CGPoint], color: Color, weight: Int16) {
        guard let param: ShapeParam =
            NSEntityDescription.insertNewObject(forEntityName: "ShapeParam", into: self.container.viewContext) as? ShapeParam else {
                fatalError("Create CoreData Error.")
            }

        param.id = UUID()
        param.mode = mode.rawValue
        param.points = points
        param.color = UIColor(color)
        param.weight = weight

        self.params.append(param)
        do {
            try self.container.viewContext.save()
        } catch {
            fatalError("Append ShapeParam Error.: \(error)")
        }
    }
    
    func undo() {
        if params.count == 0 {
            return
        }
        let param = params.last!
        self.container.viewContext.delete(param)
        do {
            try self.container.viewContext.save()
        } catch {
            fatalError("Delete ShapeParam Error: \(error)")
        }
        self.params.removeLast()
    }

    func move(index: Int, x: CGFloat, y: CGFloat) {
        let mode = self.params[index].mode
        let color = self.params[index].color
        let weight = self.params[index].weight
        self.container.viewContext.delete(self.params[index])
        var points: [CGPoint] = []
        for point in self.params[index].points! {
            points.append(CGPoint(x: point.x + x, y: point.y + y))
        }

        guard let param: ShapeParam =
            NSEntityDescription.insertNewObject(forEntityName: "ShapeParam", into: self.container.viewContext) as? ShapeParam else {
                fatalError("Create CoreData Error.")
            }
        param.id = UUID()
        param.color = color
        param.mode = mode
        param.weight = weight
        param.points = points
        self.params.append(param)
        do {
            try self.container.viewContext.save()
        } catch {
            fatalError("Move ShapeParam Error: \(error)")
        }
    }
}
