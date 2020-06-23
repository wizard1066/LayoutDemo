//
//  TimerButtonView.swift
//  LayoutDemo
//
//  Created by localadmin on 23.06.20.
//  Copyright © 2020 Mark Lucking. All rights reserved.
//

//
//  TimerButtonView.swift
//  DNANightNanny
//
//  Created by localadmin on 17.06.20.
//  Copyright © 2020 Die neue Abteilung GmbH. All rights reserved.
//

import SwiftUI
import Combine

struct Fonts {
  static func helveticaNeueMedium (size: CGFloat) -> Font {
    return Font.custom("HelveticaNeue-Medium", size: size)
  }
}

let defocusPublisher = PassthroughSubject <String,Never>()

struct TimerButtonView: View {
  
//  var label: String
  
  @State var pieSlice: Double!
  @State var label: String!
  @State var focus: Double
  @State var action: () -> Void
  
  var body: some View {
    Button(action: {
        defocusPublisher.send(self.label)
        reducePiePublisher.send(90)
        self.focus = 0.3
    }) {
      Text(label)
        .font(Fonts.helveticaNeueMedium(size: 12))
        .font(Font.title.weight(.light))
        .foregroundColor(Color.white)
        .padding(8)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.gray)
                .opacity(focus)

        )
        .frame(width: 50, height: 80, alignment: .center)
        .onReceive(defocusPublisher) { ( focus ) in
            if self.label != focus {
              self.focus = 0
            }
        }
    }
  }
}

struct TimerBar: View {
  var body: some View {
    HStack {
            TimerButtonView(pieSlice: 360, label: "3min", focus: 0.2) {
//              self.viewModel.stopCurrentlyPlayingSound()
            }.padding(8)
            
            TimerButtonView(pieSlice: 360, label: "5min", focus: 0.0) {
//              self.viewModel.stopCurrentlyPlayingSound()
            }.padding(8)
            
            TimerButtonView(pieSlice: 360, label: "10min", focus: 0.0) {
//              self.viewModel.stopCurrentlyPlayingSound()
            }.padding(8)
          }.padding(.top, 400)
  }
}

struct TimerButtonView_Previews: PreviewProvider {
    static var previews: some View {
      TimerButtonView(pieSlice: 360, label: "5min", focus: 0.0) {
        // code
      }
    }
}

