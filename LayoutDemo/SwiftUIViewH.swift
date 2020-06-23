//
//  SwiftUIViewH.swift
//  LayoutDemo
//
//  Created by localadmin on 21.06.20.
//  Copyright © 2020 Mark Lucking. All rights reserved.
//

import SwiftUI

var central: CGPoint!
var setSize:CGFloat = 64.0

struct hView: View {
    @State var zoom: CGFloat = 1.0
    @State var zoomOut: CGFloat = 1.0
    @State var xOffset: CGFloat = 0
    @State var yOffset: CGFloat = 0
    @State var change = true
    @State var vanish = 1.0
    
    var body: some View {
        ZStack() {
          ZStack {
            VStack {
                Image(systemName: "plus")
                  .background(InsideView())
                
            }
            VStack () {
              Rectangle()
                .stroke(Color.black, lineWidth: 2)
                .frame(width: 256, height: 256, alignment: .center)
                
            }
          }
          VStack {
          HStack {
            VStack() {
            if change {
              Rectangle()
                .stroke(Color.green, lineWidth: 2)
                .frame(width: setSize, height: setSize, alignment: .center)
                .padding(8)
                .opacity(vanish)
                .onTapGesture {
                  self.vanish = 0.0
                  withAnimation(.linear(duration: 4)) {
                    self.zoom = 4.0
                    self.zoomOut = 0.8
                    self.xOffset = -19
                    self.yOffset = -4
                  }
//                  DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
//                    self.change = false
//                    self.zoom = 1
//                    self.zoomOut = 0
//                  }
//                }
                }
                .padding(Edge.Set.bottom, 64.0)
                .offset(x: xOffset, y: yOffset)
//            } else {
//
//              Rectangle()
//                .stroke(Color.yellow, lineWidth: 2)
//                .frame(width: setSize * 4, height: setSize * 4, alignment: .center)
//                .padding(8)
////                .alignmentGuide(.myHorizontalAlignment) { d in d[VerticalAlignment.top] }
//                .padding(Edge.Set.bottom, 64.0)
//                .position(central)
            }
            
            }
            VStack {
              Rectangle()
                .stroke(Color.red, lineWidth: 2)
                .frame(width: setSize, height: setSize, alignment: .center)
                .padding(8)
                .padding(Edge.Set.bottom, 64.0)
                .scaleEffect(self.zoomOut, anchor: .top)
                .onTapGesture {
                  withAnimation(.linear(duration: 4)) {
                    self.zoom = 4.0
                    self.zoomOut = 0.8
                    self.xOffset = -19
                    self.yOffset = -4
                  }
                }
            }
            }
            HStack {
            VStack {
              Rectangle()
                .stroke(Color.blue, lineWidth: 2)
                .frame(width: setSize, height: setSize, alignment: .center)
                .padding(8)
                .padding(Edge.Set.bottom, 64.0)
            }.scaleEffect(self.zoomOut, anchor: .bottomLeading)
            VStack {
              Rectangle()
                .stroke(Color.purple, lineWidth: 2)
                .frame(width: setSize, height: setSize, alignment: .center)
                .padding(8)
                .padding(Edge.Set.bottom, 64.0)
            }.scaleEffect(self.zoomOut, anchor: .bottomTrailing)
            }
          }.scaleEffect(self.zoom, anchor: .topLeading)
          
        }
    }
}

struct InsideView: View {
  var body: some View {

    return VStack {
      GeometryReader { geo in
        Rectangle()
          .fill(Color.green)
          
          .opacity(0.2)
          .onAppear {
            central = CGPoint(x: geo.frame(in: .global).origin.x + (geo.size.width / 2), y: geo.frame(in: .global).origin.y - (geo.size.height / 2))
            print("central ",central)
        }
      }

    }
  }
}

struct SwiftUIViewH_Previews: PreviewProvider {
    static var previews: some View {
        hView()
    }
}
