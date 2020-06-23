//
//  SwiftUIViewJ.swift
//  LayoutDemo
//
//  Created by localadmin on 22.06.20.
//  Copyright © 2020 Mark Lucking. All rights reserved.
//

import SwiftUI

//var topLeft: CGPoint!


let shiftUp:CGFloat = 200

struct jView: View {
  @State var xWidth:CGFloat = 64
  @State var yHeight:CGFloat = 64
  @State var isShowing = true
  @State var isShowingTopLeft = false
  @State var zoomIn:CGFloat = 1.0
  @State var zoomOut:CGFloat = 1.0
  @State var topLeft: CGPoint = .zero
  @State var debug: CGPoint = .zero
  @State var fdebug = false
  
  var body: some View {
  
    return ZStack {
      ZStack {
        Image(systemName: "plus")
          .frame(width: 12, height: 12, alignment: .center)
          .background(InnerView())
        if self.fdebug {
          Image(systemName: "circle")
            .frame(width: 300, height: 300, alignment: .center)
            .position(self.debug)
            
        }
      }
      ZStack {
        if !self.isShowing {
          Rectangle()
            .stroke(Color.orange, lineWidth: 2)
            .frame(width: self.xWidth, height: self.yHeight)
            .position(self.topLeft)
            .onAppear {
              print("topLeft ",self.topLeft)
              
              withAnimation(.linear(duration: 4.0)) {
                self.topLeft = central
                
              }
          }
        }
      }
      VStack {
        HStack(alignment: .top) {
          if self.isShowing {
          
            Rectangle()
              .stroke(Color.red, lineWidth: 2)
              .frame(width: 64, height: 64)
//              .overlay(TopLeftView(topLeft: self.$topLeft))
//              .padding(Edge.Set.trailing, 24)
              .onTapGesture {
                print("central ",central)

                self.topLeft = CGPoint(x: 247.0, y: 373.0)
                self.fdebug = true
              }
            
          } else {
            Rectangle()
              .stroke(Color.red, lineWidth: 2)
              .frame(width: 64, height: 64)
              .opacity(0)
//              .padding(Edge.Set.trailing, 24)
          }
          Rectangle()
            .stroke(Color.blue, lineWidth: 2)
            .frame(width: 64, height: 64)
            .scaleEffect(self.zoomIn)
            .onTapGesture {
              self.isShowing = false
              withAnimation(.linear(duration: 4.0)) {
                self.xWidth = 256
                self.yHeight = 256
                self.zoomOut = 8.0
                self.zoomIn = 0.1
              }
            }
//          }.padding(Edge.Set.leading, 24)
        }
        HStack(alignment: .bottom) {
          Rectangle()
            .stroke(Color.green, lineWidth: 2)
            .frame(width: 64, height: 64)
            .scaleEffect(self.zoomIn)
//            .padding(Edge.Set.trailing, 24)
          Rectangle()
            .stroke(Color.purple, lineWidth: 2)
            .frame(width: 64, height: 64)
            .scaleEffect(self.zoomIn)
//            .padding(Edge.Set.leading, 24)
        }
      }.scaleEffect(self.zoomOut, anchor: .topLeading)
      
    }.padding(Edge.Set.bottom, shiftUp)
  }
  
}

struct InnerView: View {
  var body: some View {
    return VStack {
      GeometryReader { geo in
        Rectangle()
          .fill(Color.green)
          .opacity(0.2)
          .onAppear {
              central = CGPoint(x: geo.frame(in: .global).midX, y: geo.frame(in: .global).midY)
        }
      }
    }
  }
}

struct TopLeftView: View {
  @Binding var topLeft: CGPoint
  var body: some View {
    return ZStack {
      GeometryReader { geo in
        Rectangle()
          .fill(Color.yellow)
          .opacity(0.2)
          .onAppear {
            print("geo.size ",geo.size.debugDescription)
            print("geo.frame(in: .global).origin ",geo.frame(in: .global).origin.debugDescription)
            self.topLeft = CGPoint(x: geo.frame(in: .global).midX, y: geo.frame(in: .global).midY)
        }
      }
    }
  }
}

struct SwiftUIViewJ_Previews: PreviewProvider {
  static var previews: some View {
    jView()
  }
}
