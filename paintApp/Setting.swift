//
//  Setting.swift
//  paintApp
//
//  Created by 41nyaa on 2021/08/16.
//

import Foundation
import SwiftUI

struct SettingData : Codable {
    var weight: Int = 6
}

final class Setting : ObservableObject {
    @Published var data : SettingData
    private let key = "paintAppSetting"
    
    init() {
        if let defaults = UserDefaults.standard.data(forKey: key) {
            guard let data = try? JSONDecoder().decode(SettingData.self, from: defaults) else {
                fatalError("Read Setting Error.")
            }
            self.data = data
        } else {
            self.data = SettingData()
        }
    }
    
    func saveDefaults() {
        guard let defaults = try? JSONEncoder().encode(self.data) else {
            fatalError("Save Setting Error.")
        }
        UserDefaults.standard.set(defaults, forKey: key)
    }
}
