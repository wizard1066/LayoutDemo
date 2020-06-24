//
//  SwiftUIViewK.swift
//  LayoutDemo
//
//  Created by localadmin on 22.06.20.
//  Copyright © 2020 Mark Lucking. All rights reserved.
//

import SwiftUI

struct kView: View {
  @State var newView = false
  @State var center: CGPoint = .zero
  @State var left: CGPoint = CGPoint(x: UIScreen.main.bounds.minX + 100, y: UIScreen.main.bounds.minY + 100)
  @State var xPos: CGFloat = UIScreen.main.bounds.minX + 100
  @State var yPos: CGFloat = UIScreen.main.bounds.minY + 100
  @State var xPos2: CGFloat = UIScreen.main.bounds.minX + 100
  @State var yPos2: CGFloat = UIScreen.main.bounds.minY + 100
  @State var zoom:CGFloat = 1.0
  
  var body: some View {
    ZStack {
    
      ZStack {
        Image(systemName: "circle")
          .frame(width: 32, height: 32, alignment: .center)
          .position(x: xPos2, y: yPos2)
          .edgesIgnoringSafeArea(.all)
      }.border(Color.red)
      
      ZStack {
        if !newView {
          Image(systemName: "plus")
            .frame(width: 32, height: 32, alignment: .center)
            .position(x: xPos, y: yPos)
            .animation(Animation.linear(duration: 2))
            .onTapGesture {
              withAnimation(.linear(duration: 2)) {
                self.xPos = UIScreen.main.bounds.midX / 4
                self.yPos = UIScreen.main.bounds.midY / 4
                self.zoom = 4.0
              }
              
          }.scaleEffect(zoom, anchor: .topLeading)
            .edgesIgnoringSafeArea(.all)
            .border(Color.red)
        }
      }.border(Color.blue)
    }
  }
}

struct GeometryGetter: View {
    @Binding var rect: CGPoint

    var body: some View {
        return GeometryReader { geometry in
            self.makeView(geometry: geometry)
        }
    }

    func makeView(geometry: GeometryProxy) -> some View {
        DispatchQueue.main.async {
            self.rect = geometry.frame(in: .global).origin
        }

        return Rectangle().fill(Color.clear)
    }
}

struct InView: View {
  @Binding var center: CGPoint
  var body: some View {
    return VStack {
      GeometryReader { geo in
        Circle()
          .frame(width: 4, height: 4, alignment: .center)
          .opacity(0.1)
          .onAppear {
              print("geo.frame(in: .global).origin ",geo.frame(in: .global).origin.debugDescription)
            self.center = CGPoint(x: geo.frame(in: .global).origin.x, y:geo.frame(in: .global).origin.y)
          }
      }.border(Color.red)
    }
  }
}



struct SwiftUIViewK_Previews: PreviewProvider {
    static var previews: some View {
        kView()
    }
}
