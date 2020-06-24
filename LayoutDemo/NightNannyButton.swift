//
//  NightNannyButton.swift
//  LayoutDemo
//
//  Created by localadmin on 23.06.20.
//  Copyright © 2020 Mark Lucking. All rights reserved.
//

import SwiftUI

struct NightNannyButton: View {
    
    private let coloredBackground: Bool
    private let action: () -> Void
    
    public init(action: @escaping () -> Void) {
        self.coloredBackground = false
        self.action = action
    }
    
    public init(coloredBackground: Bool, action: @escaping () -> Void) {
        self.coloredBackground = coloredBackground
        self.action = action
    }
    
    var body: some View {
        Button(action: action) {
            Icons.moonAndStars
                .font(Font.title.weight(.medium))
        }
        .accentColor(coloredBackground ? Color.white : Colors.spotlightColor)
        .frame(width: bSize, height: bSize)
        .background(coloredBackground ? Colors.spotlightColor : Colors.backgroundColor)
        .mask(Circle())
        .overlay(
            RoundedRectangle(cornerRadius: bSize * 0.5)
                .stroke(Color.white)
        )
    }
    
}

struct NightNannyButton_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ZStack {
                BackgroundView()
                NightNannyButton() { }
            }
            ZStack {
                BackgroundView()
                NightNannyButton(coloredBackground: true) { }
            }
        }
    }
}

