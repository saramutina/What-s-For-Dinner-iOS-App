//
//  AppColor.swift
//  What's For Dinner
//
//  Created by Katie Saramutina on 22.04.2022.
//

import SwiftUI

struct AppColor {
    static let background: Color = Color(.sRGB,
                                         red: 233/255,
                                         green: 255/255,
                                         blue: 219/255,
                                         opacity: 1)
    static let button: Color = Color(.sRGB,
                                               red: 223/255,
                                               green: 245/255,
                                               blue: 209/255,
                                               opacity: 1)
    static let foreground: Color = Color(.sRGB,
                                           red: 0/255,
                                           green: 66/255,
                                           blue: 37/255,
                                           opacity: 1)
}

extension Color: RawRepresentable {
    public init?(rawValue: String) {
        do {
            let encodedData = rawValue.data(using: .utf8)!
            let components = try JSONDecoder().decode([Double].self, from: encodedData)
            self = Color(red: components[0],
                         green: components[1],
                         blue: components[2],
                         opacity: components[3])
        }
        catch {
            return nil
        }
    }
    
    public var rawValue: String {
        guard let cgFloatComponents = UIColor(self).cgColor.components else { return "" }
        let doubleComponents = cgFloatComponents.map {
            Double($0)
        }
        do {
            let encodedComponents = try JSONEncoder().encode(doubleComponents)
            return String(data: encodedComponents, encoding: .utf8) ?? ""
        }
        catch {
            return ""
        }
    }
}
