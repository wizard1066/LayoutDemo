//
//  ViewM.swift
//  LayoutDemo
//
//  Created by localadmin on 23.06.20.
//  Copyright © 2020 Mark Lucking. All rights reserved.
//

import SwiftUI
import Combine

let relocatePublisher = PassthroughSubject <Void,Never>()

let viewWidth = UIScreen.main.bounds.width
let viewHeight = UIScreen.main.bounds.height
let viewMaxX = UIScreen.main.bounds.maxX
let viewMinX = UIScreen.main.bounds.minX
let viewMidX = UIScreen.main.bounds.midX
let viewMaxY = UIScreen.main.bounds.maxY
let viewMinY = UIScreen.main.bounds.minY
let viewMidY = UIScreen.main.bounds.midY

let bSize = viewMaxX * 0.25
let bZoom:CGFloat = 3.0

let viewQX = viewMaxX * 0.25
let viewQY = viewMaxY * 0.20
let viewQZ = viewMaxY * 0.4
let viewBZ = viewMaxY * 0.8
let viewCalcY = viewMaxY * 0.1
let viewCalcX = viewMaxX * 0.1

struct mView: View {

  @State var testRun = false
  @State var rainOffsetX:CGFloat = 0.0
  @State var rainOffsetY:CGFloat = 0.0
  
  @ObservedObject var viewModel = ViewModels.soundPlayingViewModel
  
  @State var zoomHeart:CGFloat = 1.0
  @State var zoomRain:CGFloat = 1.0
  @State var zoomWashingMachine:CGFloat = 1.0
  @State var zoomWind:CGFloat = 1.0
  
  @State var zoomFocus = UnitPoint.topLeading
  
  @State var isVisibleHeart:Bool = true
  @State var isVisibleRain:Bool = true
  @State var isVisibleWashingMachine:Bool = true
  @State var isVisibleWind:Bool = true
  
  @State var newHeartX: CGFloat = .zero
  @State var newHeartY: CGFloat = .zero
  
  @State var newRainX: CGFloat = .zero
  @State var newRainY: CGFloat = .zero
  
  @State var newWashingMachineX: CGFloat = .zero
  @State var newWashingMachineY: CGFloat = .zero
  
  @State var newWindX: CGFloat = .zero
  @State var newWindY: CGFloat = .zero
  
  @State var relocateHeartX: CGFloat = viewQX
  @State var relocateHeartY: CGFloat = viewQY
  
  @State var relocateRainX: CGFloat = viewQX * 3
  @State var relocateRainY: CGFloat = viewQY
  
  @State var relocateWashingMachineX: CGFloat = viewQX
  @State var relocateWashingMachineY: CGFloat = viewQY * 3
  
  @State var relocateWindX: CGFloat = viewQX * 3
  @State var relocateWindY: CGFloat = viewQY * 3
  
  @State var relocateNightNannyX: CGFloat = viewMidX
  @State var relocateNightNannyY: CGFloat = viewBZ
  
  @State var fadeBar = 1.0
  @State var isntListening: Bool = true
  
  @State private var tap = false
  @State private var bottomRect: CGRect = .zero
  
  
  var body: some View {
    
    ZStack {
      ZStack {
        BackgroundView()
        if isVisibleHeart {
          CircularButtonView(image: Icons.heartBeat, size: bSize, isVisible: false, action: {
            self.newHeartX = viewQX
            self.newHeartY = viewQY
            self.isVisibleHeart = false
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
              withAnimation(.linear(duration: 0.2)) {
                self.fadeBar = 1.0
              }
            }
          }).position(CGPoint(x: relocateHeartX, y: relocateHeartY))
            .onReceive(relocatePublisher) { ( newCords ) in
              if self.isntListening {
                withAnimation(.linear(duration: 1.0)) {
                  self.relocateHeartX = viewQX * 2
                  self.relocateHeartY = viewQZ
                }
              } else {
                withAnimation(.linear(duration: 1.0)) {
                  self.relocateHeartX = viewQX
                  self.relocateHeartY = viewQY
                }
              }
          }
        }
        
        if isVisibleRain {
          CircularButtonView(image: Icons.rain, size: bSize, action: {
            self.newRainX = viewQX * 3
            self.newRainY = viewQY
            self.isVisibleRain = false
          }).onReceive(relocatePublisher) { ( newCords ) in
            if self.isntListening {
              withAnimation(.linear(duration: 1.0)) {
                self.relocateRainX = viewQX * 2
                self.relocateRainY = viewQZ
              }
            } else {
              withAnimation(.linear(duration: 1.0)) {
                self.relocateRainX = viewQX * 3
                self.relocateRainY = viewQY
              }
            }
          }
          .position(CGPoint(x: relocateRainX, y: relocateRainY))
        }
        
        if isVisibleWashingMachine {
          CircularButtonView(image: Icons.washingMachine, size: bSize, action: {
            self.newWashingMachineX = viewQX
            self.newWashingMachineY = viewQY * 3
            self.isVisibleWashingMachine = false
          }).onReceive(relocatePublisher) { ( newCords ) in
            if self.isntListening {
              withAnimation(.linear(duration: 1.0)) {
                self.relocateWashingMachineX = viewQX * 2
                self.relocateWashingMachineY = viewQZ
              }
            } else {
              withAnimation(.linear(duration: 1.0)) {
                self.relocateWashingMachineX = viewQX
                self.relocateWashingMachineY = viewQY * 3
              }
            }
          }
          .position(CGPoint(x: relocateWashingMachineX, y: relocateWashingMachineY))
        }
        
        if isVisibleWind {
          CircularButtonView(image: Icons.wind, size: bSize, action: {
            self.newWindX = viewQX * 3
            self.newWindY = viewQY * 3
            self.isVisibleWind = false
          }).onReceive(relocatePublisher) { ( newCords ) in
            if self.isntListening {
              withAnimation(.linear(duration: 1.0)) {
                self.relocateWindX = viewQX * 2
                self.relocateWindY = viewQZ
              }
            } else {
              withAnimation(.linear(duration: 1.0)) {
                self.relocateWindX = viewQX * 3
                self.relocateWindY = viewQY * 3
              }
            }
          }
          .position(CGPoint(x: relocateWindX, y: relocateWindY))
        }
        
      }.scaleEffect(zoomHeart, anchor: zoomFocus)
      .scaleEffect(zoomRain, anchor: zoomFocus)
      .scaleEffect(zoomWashingMachine, anchor: zoomFocus)
      .scaleEffect(zoomWind, anchor: zoomFocus)
      
      ZStack {
        if !isVisibleHeart {
          ConfigureButtonView(image: Icons.heartBeat) {
            self.fadeBar = 0.0
            withAnimation(.linear(duration: 0.2)) {
              self.fadeBar = 0.0
            }
            withAnimation(.linear(duration: 0.8)) {
              self.newHeartX = viewQX
              self.newHeartY = viewQY
            }
            withAnimation(.linear(duration: 1.0)) {
              self.zoomHeart = 1.0
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
              withAnimation(.linear(duration: 0.6)) {
                self.isVisibleHeart = true
              }
            }
          }.position(CGPoint(x: newHeartX, y: newHeartY))
          .rectReader($bottomRect, in: .named("main"))
            .onAppear {
              self.zoomFocus = UnitPoint.topLeading
              
              withAnimation(.linear(duration: 1.0)) {
                self.newHeartY = (viewMaxY * 0.45) / bZoom - 16
                self.newHeartX = (viewMaxX * 0.165)
                self.zoomHeart = bZoom
              }
              
          }.scaleEffect(zoomHeart, anchor: zoomFocus)
          TimerBar()
            .opacity(fadeBar)
            .position(x: viewMidX, y: viewQZ)
        }
        if !isVisibleRain {
          ConfigureButtonView(image: Icons.rain) {
            self.fadeBar = 0.0
            withAnimation(.linear(duration: 0.2)) {
              self.fadeBar = 0.0
            }
            withAnimation(.linear(duration: 0.8)) {
              self.newRainX = viewQX * 3
              self.newRainY = viewQY
            }
            withAnimation(.linear(duration: 1.0)) {
              self.zoomRain = 1.0
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
              withAnimation(.linear(duration: 0.6)) {
                self.isVisibleRain = true
              }
            }
          }
          .offset(x: rainOffsetX, y: rainOffsetY)
          .position(CGPoint(x: newRainX, y: newRainY))
          .rectReader($bottomRect, in: .named("main"))
            .onAppear {
              self.zoomFocus = UnitPoint.topTrailing
              // The magic number 16 is the safe area on an iPhone 11
              withAnimation(.linear(duration: 1.0)) {
                self.newRainX = (viewMaxX * 0.83)
                self.newRainY = (viewMaxY * 0.45) / bZoom - 16
                self.zoomRain = bZoom
                self.fadeBar = 1
              }
              
          }.scaleEffect(zoomRain, anchor: zoomFocus)
          TimerBar()
            .opacity(fadeBar)
            .position(x: viewMidX, y: viewQZ)
        }
        
        if !isVisibleWashingMachine {
          ConfigureButtonView(image: Icons.washingMachine) {
            self.fadeBar = 0.0
            withAnimation(.linear(duration: 0.2)) {
              self.fadeBar = 0.0
            }
            withAnimation(.linear(duration: 0.8)) {
              self.newWashingMachineX = viewQX
              self.newWashingMachineY = viewQY * 3
            }
            withAnimation(.linear(duration: 1.0)) {
              self.zoomWashingMachine = 1.0
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
              withAnimation(.linear(duration: 0.6)) {
                self.isVisibleWashingMachine = true
              }
            }
          }.position(CGPoint(x: newWashingMachineX, y: newWashingMachineY))
          .rectReader($bottomRect, in: .named("main"))
            .onAppear {
            self.zoomFocus = UnitPoint.bottomLeading
              withAnimation(.linear(duration: 1.0)) {
                self.newWashingMachineY = (viewMaxY * 0.74)
                self.newWashingMachineX = (viewMaxX * 0.165)
                self.zoomWashingMachine = bZoom
                self.fadeBar = 1
              }
              
              DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                print("self.bottomRect.width ",self.bottomRect.height,viewMaxY,viewCalcY * 7.41)
              }
              
          }.scaleEffect(zoomWashingMachine, anchor: .bottomLeading)
          TimerBar()
            .opacity(fadeBar)
            .position(x: viewMidX, y: viewQZ)
        }
        if !isVisibleWind {
          ConfigureButtonView(image: Icons.wind) {
            self.fadeBar = 0.0
            withAnimation(.linear(duration: 0.2)) {
              self.fadeBar = 0.0
            }
            withAnimation(.linear(duration: 0.8)) {
              self.newWindX = viewQX * 3
              self.newWindY = viewQY * 3
            }
            withAnimation(.linear(duration: 1.0)) {
              self.zoomWind = 1.0
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
              withAnimation(.linear(duration: 0.6)) {
                self.isVisibleWind = true
              }
            }
          }.position(CGPoint(x: newWindX, y: newWindY))
          .rectReader($bottomRect, in: .named("main"))
            .onAppear {
              self.zoomFocus = UnitPoint.bottomTrailing
              withAnimation(.linear(duration: 1.0)) {
                self.newWindX = (viewMaxX * 0.83)
                self.newWindY = (viewMaxY * 0.74)
                self.zoomWind = bZoom
                self.fadeBar = 1
              }
          }
          .scaleEffect(zoomWind, anchor: self.zoomFocus)
          TimerBar()
            .opacity(fadeBar)
            .position(x: viewMidX, y: viewQZ)
        }
      }
      VStack {
        NightNannyButton() {
          relocatePublisher.send()
          if self.isntListening {
            withAnimation(.linear(duration: 1.1)) {
              self.relocateNightNannyX = viewMidX
              self.relocateNightNannyY = viewQZ
            }
          } else {
            withAnimation(.linear(duration: 1.1)) {
              self.relocateNightNannyX = viewMidX
              self.relocateNightNannyY = viewBZ
            }
          }
          // Time needed to do the animation above
          DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
            self.isntListening.toggle()
          }
        }.position(x: relocateNightNannyX, y: relocateNightNannyY)
      }
      ZStack {
//        if testRun {
          Image(systemName: "plus")
            .frame(width: 32, height: 32, alignment: .center)
            .foregroundColor(Color.red)
            .position(x: viewMidX, y: viewQZ)
//            .rectReader($bottomRect, in: .named("main"))
//        }
      }
    }.coordinateSpace(name: "main")
  }
}

// code SO https://stackoverflow.com/questions/60494745/swiftui-set-position-to-center-of-different-view
// only using it to debug/understand what is happening within the animation @ this point

extension View {
    func rectReader(_ binding: Binding<CGRect>, in space: CoordinateSpace) -> some View {
        self.background(GeometryReader { (geometry) -> AnyView in
            let rect = geometry.frame(in: space)
            DispatchQueue.main.async {
                binding.wrappedValue = rect
                print("rect ",rect)
            }
            return AnyView(Rectangle().fill(Color.clear))
        })
    }
}

struct ViewM_Previews: PreviewProvider {
  static var previews: some View {
    mView()
  }
}


