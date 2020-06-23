//
//  PieArcView.swift
//  LayoutDemo
//
//  Created by localadmin on 23.06.20.
//  Copyright © 2020 Mark Lucking. All rights reserved.
//

import SwiftUI

//
//  PieArc.swift
//  DNANightNanny
//
//  Created by localadmin on 17.06.20.
//  Copyright © 2020 Die neue Abteilung GmbH. All rights reserved.
//

import SwiftUI
import Combine

let reducePiePublisher = PassthroughSubject <Double, Never>()

struct PieArcView: View {
  @State var pieSlice: Double
  @State private var slicerTimer:Timer!
  @Binding var show: Bool
  
  var body: some View {
             PieArc(pieSlice: self.pieSlice)
            .fill(Color.black)
            .opacity(0.8)
            .onReceive(reducePiePublisher) { ( amount ) in
              self.slicerTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
                if self.pieSlice > 0 {
                  self.pieSlice -= 3
                }
                if self.pieSlice == 0 {
                  self.slicerTimer.invalidate()
                  withAnimation(.linear(duration: 2)) {
                    self.show = false
                  }
                }
              }

//              Animation on this doesn't work
//              withAnimation(.linear(duration:6)) {
//                self.pieSlice = 180
//              }
              print("pieSlideB ",self.pieSlice)
          }
          .rotationEffect(.degrees(-90))
  }
}

struct PieArc: Shape {
    @State var pieSlice: Double
    func path(in rect: CGRect) -> Path {
      var piePath = Path()
      piePath.addArc(center: CGPoint(x: rect.width/2, y:rect.height/2), radius: 160, startAngle: .degrees(pieSlice), endAngle: .degrees(360), clockwise: true)
      piePath.addLine(to: CGPoint(x: rect.width/2, y:rect.height/2))
      piePath.closeSubpath()
      return piePath
    }
}

//struct PieArcView_Previews: PreviewProvider {
//    static var previews: some View {
//      PieArc(pieSlice: 90.0)
//    }
//}


//struct PieArcView_Previews: PreviewProvider {
//    static var previews: some View {
//        PieArcView()
//    }
//}
