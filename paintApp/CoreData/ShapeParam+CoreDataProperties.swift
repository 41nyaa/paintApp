//
//  ShapeParam+CoreDataProperties.swift
//  paintApp
//
//  Created by 41nyaa on 2021/08/20.
//
//

import Foundation
import CoreData
import SwiftUI
import UIKit

extension ShapeParam {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ShapeParam> {
        return NSFetchRequest<ShapeParam>(entityName: "ShapeParam")
    }

    @NSManaged public var color: UIColor?
    @NSManaged public var id: UUID?
    @NSManaged public var mode: Int16
    @NSManaged public var points: [CGPoint]?
    @NSManaged public var weight: Int16

}

extension ShapeParam : Identifiable {
}
