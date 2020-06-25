//
//  SwiftUIViewN.swift
//  LayoutDemo
//
//  Created by localadmin on 25.06.20.
//  Copyright © 2020 Mark Lucking. All rights reserved.
//

import SwiftUI

import SwiftUI

struct PositionData: Identifiable {
    let id: Int
    let center: Anchor<CGPoint>
}
struct Positions: PreferenceKey {
    static var defaultValue: [PositionData] = []
    static func reduce(value: inout [PositionData], nextValue: () -> [PositionData]) {
        value.append(contentsOf: nextValue())
    }
}

struct PositionReader: View {
    let tag: Int
    var body: some View {
        Color.clear.anchorPreference(key: Positions.self, value: .center) { (anchor)  in
                [PositionData(id: self.tag, center: anchor)]
        }
    }
}

struct nView: View {
    @State var tag = 0
    @State var zoom:CGFloat = 1.0
    @State var relocate = false
    var body: some View {
        ZStack {
            VStack {
                ZStack {
                  Rectangle()
                  .frame(width: 32, height: 32)
                  .background(PositionReader(tag: 0))
                      .onTapGesture {
                        self.tag = 0
                        self.relocate.toggle()
                      }
                  .overlay(
                    Rectangle()
                      .frame(width: 16, height: 16)
                      .position(x: relocate ? 50: 100, y: relocate ? 50: 100)
                      .scaleEffect(zoom)
                      .onAppear(perform: {
                        if self.relocate {
                          withAnimation {
                            self.zoom = 1.0
                          }
                        } else {
                          withAnimation {
                            self.zoom = 2.0
                          }
                        }
                      })
                    )
                }
            }
                
        }
        .overlayPreferenceValue(Positions.self) { preferences in
            GeometryReader { proxy in
                Rectangle()
                  .frame(width: 50, height: 50)
                  .position( self.getPosition(proxy: proxy, tag: self.tag, preferences: preferences))

            }
        }
    }
    func getPosition(proxy: GeometryProxy, tag: Int, preferences: [PositionData])->CGPoint {
        let p = preferences.filter({ (p) -> Bool in
            p.id == tag
            })[0]
            print(proxy[p.center])
        return proxy[p.center]
    }
}


