//
//  DNANightNanny.swift
//  LayoutDemo
//
//  Created by localadmin on 23.06.20.
//  Copyright © 2020 Mark Lucking. All rights reserved.
//

import SwiftUI

final class ViewCords: ObservableObject {
  @Published var lastCordinates:CGPoint = .zero
  @Published var heartCord:CGPoint = .zero
  @Published var rainCord:CGPoint = .zero
  @Published var washingCord:CGPoint = .zero
  @Published var windCord:CGPoint = .zero
}

struct CircularButtonView: View {

    @EnvironmentObject var env: ViewCords
    
    private let image: Image
    private let coloredBackground: Bool
    private let size: CGFloat
    private let action: () -> Void
    private let icon:String
    private let isVisible: Bool
    
    
    @State private var start = false
    @State private var newX:CGFloat = 0
    @State private var newY:CGFloat = 0
    @State private var mover = false
    @State private var isVisibleX:Double = 1
    @State private var zoom:CGFloat = 1.0
  
    
    public init(image: Image, icon: String, action: @escaping () -> Void) {
        self.image = image
        self.coloredBackground = false
        self.size = 80.0
        self.action = action
        self.icon = icon
        self.isVisible = true
    }
    
    public init(image: Image, coloredBackground: Bool, action: @escaping () -> Void) {
        self.image = image
        self.coloredBackground = coloredBackground
        self.size = 80.0
        self.action = action
        self.icon = ""
        self.isVisible = true
    }
    
    public init(image: Image, size: CGFloat, action: @escaping () -> Void) {
        self.image = image
        self.coloredBackground = false
        self.size = size
        self.action = action
        self.icon = ""
        self.isVisible = true
    }
    
    public init(image: Image, size: CGFloat, isVisible: Bool, action: @escaping () -> Void) {
        self.image = image
        self.coloredBackground = false
        self.size = size
        self.action = action
        self.icon = ""
        self.isVisible = isVisible
    }
    
    var body: some View {
        return Button(action: {
          if self.isVisible {
            self.isVisibleX = 0.0
          }
          self.action()
        }) {
            self.image.font(Font.title.weight(.medium))
        }
        .accentColor(self.coloredBackground ? Color.white : Colors.keyColor)
        .frame(width: self.size, height: self.size)
        .background(self.coloredBackground ? Colors.spotlightColor : Colors.buttonBackgroundColor)
        .mask(Circle())
        .opacity(isVisibleX)
  }
}


