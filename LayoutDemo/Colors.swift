//
//  Colors.swift
//  LayoutDemo
//
//  Created by localadmin on 23.06.20.
//  Copyright © 2020 Mark Lucking. All rights reserved.
//

import Foundation
import UIKit
import SwiftUI

class Colors {
    
    static let backgroundColor: Color = Color(red: 22/255.0, green: 22/255.0, blue: 25/255.0)
    static let buttonBackgroundColor: Color = Color(red: 33/255.0, green: 33/255.0, blue: 44/255.0)
    
    static let textColor: Color = Color(red: 248/255.0, green: 248/255.0, blue: 248/255.0)
    
    static let keyColor: Color = Color(red: 92/255.0, green: 96/255.0, blue: 222/255.0)
    static let spotlightColor: Color = Color(red: 248/255.0, green: 214/255.0, blue: 74/255.0)
    
    static let activeIconColor: Color = Color(red: 222/255.0, green: 222/255.0, blue: 224/255.0)
    
}

extension Color {
  init(_ hex: Int, opacity: Double = 1.0) {
    let red = Double((hex & 0xff0000) >> 16) / 255.0
    let green = Double((hex & 0xff00) >> 8) / 255.0
    let blue = Double((hex & 0xff) >> 0) / 255.0
    self.init(.sRGB, red: red, green: green, blue: blue, opacity: opacity)
  }
}
