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
    @State var extra: CGPoint = .zero
    
    var body: some View {
      ZStack {
      ZStack {
      
        Image(systemName: "minus")
          .frame(width: 32, height: 32, alignment: .center)
          .background(InView(center: $extra))
        
        Image(systemName: "triangle")
          .frame(width: 32, height: 32, alignment: .center)
          .border(Color.yellow)
          
//          .background(InView(center: self.$center))
//          .background(GeometryGetter(rect: $extra))
          .onTapGesture {
            self.newView = true
          }.edgesIgnoringSafeArea(.all)
        }
        
        ZStack {
          if self.newView {
            Image(systemName: "circle")
              .frame(width: 32, height: 32, alignment: .center)
              .edgesIgnoringSafeArea(.all)
              .position(self.extra)
  //            .position(x: 207, y: 448)
            }
         }
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
