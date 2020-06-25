//
//  SwiftUIViewO.swift
//  LayoutDemo
//
//  Created by localadmin on 25.06.20.
//  Copyright © 2020 Mark Lucking. All rights reserved.
//

import SwiftUI

//let viewWidth = UIScreen.main.bounds.width
//let viewHeight = UIScreen.main.bounds.height
//let viewMaxX = UIScreen.main.bounds.maxX
//let viewMinX = UIScreen.main.bounds.minX
//let viewMidX = UIScreen.main.bounds.midX
//let viewMaxY = UIScreen.main.bounds.maxY
//let viewMinY = UIScreen.main.bounds.minY
//let viewMidY = UIScreen.main.bounds.midY
//
//let bSize = viewMaxX * 0.25
//let bZoom:CGFloat = 3.0
//
//let viewQX = viewMaxX * 0.25
//let viewQY = viewMaxY * 0.20
//let viewQZ = viewMaxY * 0.4
//let viewBZ = viewMaxY * 0.8
//let viewCalcY = viewMaxY * 0.1
//let viewCalcX = viewMaxX * 0.1

let viewQK = viewMaxY * 0.50
let viewQH = viewMaxX * 0.20

struct oView: View {
  @State var rainLocation = Alignment.topTrailing
  @State var heartLocation = Alignment.topLeading
  @State var washingMachineLocation = Alignment.bottomLeading
  @State var windLocation = Alignment.bottomTrailing
  
  @State var shadowHeart = 1.0
  @State var shadowRain = 1.0
  @State var shadowWashingMachine = 1.0
  @State var shadowWind = 1.0
  
  @State var heartOpactity = 1.0
  @State var rainOpactity = 1.0
  @State var washingMachineOpactity = 1.0
  @State var windOpactity = 1.0
  
  @State var relocateNightNannyX: CGFloat = viewMidX
  @State var relocateNightNannyY: CGFloat = viewBZ
  
  @State var fadeBar = 1.0
  @State var isntListening: Bool = true
  
  @State var washingMachineOffsetY:CGFloat = 0
  @State var windOffsetY:CGFloat = 0
  
  @State var zoomHeart:CGFloat = 1.0
  @State var zoomRain:CGFloat = 1.0
  @State var zoomWashingMachine:CGFloat = 1.0
  @State var zoomWind:CGFloat = 1.0
  
  @State var tag:Bool = true
  @State var tag2:Bool = false
  @State var centerPoint: CGPoint = .zero
  @State var doZoom:CGFloat = 1.0
  
  @State var zoomFocus = UnitPoint.topLeading
  
  var body: some View {
    
    return ZStack {
      BackgroundView()
      
      ZStack {
        ZStack(alignment: heartLocation) {
          CircularButtonView(image: Icons.heartBeat, size: bSize, isVisible: false, action: {
            // dummy
          })
        }.frame(width: UIScreen.main.bounds.width - viewQH, height: UIScreen.main.bounds.height - viewQK, alignment: heartLocation)
          .opacity(shadowHeart)
        
        ZStack(alignment: rainLocation) {
          CircularButtonView(image: Icons.rain, size: bSize, isVisible: true, action: {
            // dummy
          })
        }.frame(width: UIScreen.main.bounds.width - viewQH, height: UIScreen.main.bounds.height - viewQK, alignment: rainLocation)
          .opacity(shadowRain)
        
        ZStack(alignment: washingMachineLocation) {
          CircularButtonView(image: Icons.washingMachine, size: bSize, isVisible: false, action: {
            // dummy
          })
        }.frame(width: UIScreen.main.bounds.width - viewQH, height: UIScreen.main.bounds.height - viewQK, alignment: washingMachineLocation)
          .opacity(shadowWashingMachine)
        
        ZStack(alignment: windLocation) {
          CircularButtonView(image: Icons.wind, size: bSize, isVisible: false, action: {
            // dummy
          })
        }.frame(width: UIScreen.main.bounds.width - viewQH, height: UIScreen.main.bounds.height - viewQK, alignment: windLocation)
          .opacity(shadowWind)
      }.frame(width: UIScreen.main.bounds.width - viewQH, height: UIScreen.main.bounds.height - viewQK, alignment: .center)
        .scaleEffect(doZoom, anchor: zoomFocus)
      
      //      Color.black
      
      ZStack(alignment: heartLocation) {
        CircularButtonView(image: Icons.heartBeat, size: bSize, isVisible: false, action: {
          if self.tag {
            self.zoomFocus = UnitPoint.topLeading
            self.rainOpactity = 0.0
            self.windOpactity = 0.0
            self.washingMachineOpactity = 0.0
            self.shadowHeart = 0.0
            withAnimation(.linear(duration: 4)) {
              self.zoomHeart = 3.0
              self.heartLocation = Alignment.center
              self.doZoom = 3.0
            }
          } else {
            withAnimation(.linear(duration: 4)) {
              self.heartLocation = Alignment.topLeading
              self.zoomHeart = 1.0
              self.doZoom = 1.0
            }
            DispatchQueue.main.asyncAfter(deadline: .now()+4) {
              self.rainOpactity = 1.0
              self.windOpactity = 1.0
              self.washingMachineOpactity = 1.0
              self.shadowHeart = 1.0
            }
          }
          self.tag.toggle()
        })
          .scaleEffect(zoomHeart)
      }
      .frame(width: UIScreen.main.bounds.width - viewQH, height: UIScreen.main.bounds.height - viewQK, alignment: heartLocation)
      .opacity(heartOpactity)
      
      
      ZStack(alignment: rainLocation) {
        CircularButtonView(image: Icons.rain, size: bSize, isVisible: false, action: {
          if self.tag {
            self.zoomFocus = UnitPoint.topTrailing
            self.heartOpactity = 0.0
            self.windOpactity = 0.0
            self.washingMachineOpactity = 0.0
            self.shadowRain = 0.0
            withAnimation(.linear(duration: 4)) {
              self.zoomRain = 3.0
              self.rainLocation = Alignment.center
              self.doZoom = 3.0
            }
          } else {
            withAnimation(.linear(duration: 4)) {
              self.rainLocation = Alignment.topTrailing
              self.zoomRain = 1.0
              self.doZoom = 1.0
            }
            DispatchQueue.main.asyncAfter(deadline: .now()+4) {
              self.heartOpactity = 1.0
              self.windOpactity = 1.0
              self.washingMachineOpactity = 1.0
              self.shadowRain = 1.0
            }
          }
          self.tag.toggle()
        })
          .scaleEffect(zoomRain)
      }
      .frame(width: UIScreen.main.bounds.width - viewQH, height: UIScreen.main.bounds.height - viewQK, alignment: rainLocation)
      .opacity(rainOpactity)
      
      ZStack(alignment: washingMachineLocation) {
        CircularButtonView(image: Icons.washingMachine, size: bSize, isVisible: false, action: {
          if self.tag {
            self.zoomFocus = UnitPoint.bottomLeading
            self.heartOpactity = 0.0
            self.rainOpactity = 0.0
            self.windOpactity = 0.0
            self.shadowWashingMachine = 0.0
            withAnimation(.linear(duration: 4)) {
              self.zoomWashingMachine = 3.0
              self.washingMachineLocation = Alignment.center
              self.doZoom = 3.0
            }
          } else {
            withAnimation(.linear(duration: 4)) {
              self.washingMachineLocation = Alignment.bottomLeading
              self.zoomWashingMachine = 1.0
              self.doZoom = 1.0
            }
            DispatchQueue.main.asyncAfter(deadline: .now()+4) {
              self.heartOpactity = 1.0
              self.windOpactity = 1.0
              self.rainOpactity = 1.0
              self.shadowWashingMachine = 1.0
            }
          }
          self.tag.toggle()
        })
          .scaleEffect(zoomWashingMachine)
      }.frame(width: UIScreen.main.bounds.width - viewQH, height: UIScreen.main.bounds.height - viewQK, alignment: washingMachineLocation)
        .opacity(washingMachineOpactity)
      
      
      ZStack(alignment: windLocation) {
        CircularButtonView(image: Icons.wind, size: bSize, isVisible: false, action: {
          if self.tag {
            self.zoomFocus = UnitPoint.bottomTrailing
            self.heartOpactity = 0.0
            self.rainOpactity = 0.0
            self.washingMachineOpactity = 0.0
            self.shadowWind = 0.0
            withAnimation(.linear(duration: 4)) {
              self.zoomWind = 3.0
              self.windLocation = Alignment.center
              self.doZoom = 3.0
            }
          } else {
            withAnimation(.linear(duration: 4)) {
              self.windLocation = Alignment.bottomTrailing
              self.zoomWind = 1.0
              self.doZoom = 1.0
            }
            DispatchQueue.main.asyncAfter(deadline: .now()+4) {
              self.heartOpactity = 1.0
              self.rainOpactity = 1.0
              self.washingMachineOpactity = 1.0
              self.shadowWind = 1.0
            }
          }
          self.tag.toggle()
        })
          .scaleEffect(zoomWind)
      }.frame(width: UIScreen.main.bounds.width - viewQH, height: UIScreen.main.bounds.height - viewQK, alignment: windLocation)
        .opacity(windOpactity)
      
      if !tag {
        ZStack {
          Rectangle()
            .stroke(Color.green, lineWidth: 2)
            .frame(width: 48, height: 48, alignment: .center)
            .onTapGesture {
              self.tag.toggle()
          }
        }.frame(width: 256, height: 256, alignment: .center)
          .scaleEffect(zoomRain, anchor: .center)
          .scaleEffect(zoomHeart, anchor: .center)
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
        Image(systemName: "plus")
          .frame(width: 32, height: 32, alignment: .center)
          .foregroundColor(Color.red)
          .position(x: viewMidX, y: viewQZ)
      }
      
    }.frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - viewQY, alignment: .center)
  }
}


