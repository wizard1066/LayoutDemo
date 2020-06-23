//
//  ConfigureButtonView.swift
//  DNANightNanny
//
//  Created by localadmin on 16.06.20.
//  Copyright © 2020 Die neue Abteilung GmbH. All rights reserved.
//

import SwiftUI

//
//  CircularButtonView2.swift
//  DNANightNanny
//
//  Created by localadmin on 16.06.20.
//  Copyright © 2020 Die neue Abteilung GmbH. All rights reserved.
//

import SwiftUI
import Combine

struct ConfigureButtonView: View {

  @EnvironmentObject var env: ViewCords
  
  private let image: Image
  private let size: CGFloat
  private let action: () -> Void
  
  @State private var start = false
  @State private var show = false
  @State private var showPie = false
  @State private var pieSlice:Double = 360
  @State private var coloredBackground = false
 
  
  public init(image: Image, action: @escaping () -> Void) {
    self.image = image
    self.action = action
    self.size = 80
    self.start = true
  }
  
  var body: some View {
      return ZStack {
//        if self.show {
          Button(action: {
//              DispatchQueue.main.asyncAfter(deadline: .now()) {
                self.action()
//              }
          }) {
            self.image.font(Font.title.weight(.medium))
          }
          .accentColor(self.coloredBackground ? Color.white : Colors.keyColor)
          .frame(width: self.size, height: self.size)
          .background(self.coloredBackground ? Color.init(0x5e5ce6) : Colors.buttonBackgroundColor)
          .mask(Circle())
          .onAppear {
            self.showPie = true
            withAnimation(.linear(duration:1)) {
              self.coloredBackground = true
            }
          }
          .onDisappear {
            withAnimation(.linear(duration:0.5)) {
              self.coloredBackground = false
            }
          }
          if self.showPie {
            PieArcView(pieSlice: pieSlice, show: $show)
          }
        }
    }
}

struct ConfigureButtonView_Previews: PreviewProvider {
    static var previews: some View {
      CircularButtonView(image: Icons.heartBeat, icon: "") {
        }
    }
}

